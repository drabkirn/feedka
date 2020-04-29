class FeedsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :destroy, :public, :private]
  before_action :set_feed, only: [:destroy, :public, :private]
  before_action :decrypt_feed, only: [:public, :private]

  ## GET /feeds
  ## Only logged in users can see their feeds
  def index
    @feeds = current_user.feeds.all.order("updated_at DESC")
  end

  ## GET /f/:username
  ## Anyone can use this link and submit feedback
  def feedback
    ## Pick the user by username params
    ## If user is not found, redirect to root_path with alert message
    user = User.find_by(username: params[:username])
    if !user
      redirect_to root_path, alert: Message.user_not_found
      return
    end

    ## If users email is not confirmed, don't show this page
    if !user.confirmed?
      redirect_to root_path, alert: Message.user_email_not_confirmed
      return
    end

    @feed = Feed.new

    ## Send public only feeds to the view
    public_feeds = []
    user.feeds && user.feeds.order("updated_at DESC").each do |feed|
      public_feeds << feed if feed.public?
    end

    @public_feeds = public_feeds
  end

  def create
    require 'uri'
    require 'net/http'
    require 'json'

    @feed = Feed.new(feed_params)

    ## We cannot use `user_id` as hidden field in forms
    ## So this workfix, helps get the username
    ref_path = URI(request.referer).path
    username = ref_path.split("/").last
    user = User.find_by(username: username)

    ## Now set the user
    ## If user is somehow not set, Feed won't save and returns the error to view
    @feed.user = user if user

    if @feed.valid?
      ## Take the content, apply content moderation to it
      ## Sends back success and error arrays
      ## If error is empty move on, if success is empty move on
      moderation_success, moderation_error = content_moderation(@feed.content)
      
      ## If error is not empty -> Throw error
      if !moderation_error.empty?
        redirect_to root_path, custom_alert: moderation_error
        return
      end

      ## If success is not empty -> Means problem in content -> Throw error
      if !moderation_success.empty?
        redirect_to root_path, custom_alert: moderation_success
        return
      end

      ## Send the feedback from 10 - 300 mins later generated randomly
      generate_mins = rand(10..300)
      FeedSaveJob.set(wait: generate_mins.minutes).perform_later(@feed.user.id, @feed.content)
      redirect_to root_path, notice: Message.feed_created
    else
      redirect_to ref_path, custom_alert: @feed.errors.full_messages
    end
  end

  ## DELETE /feeds
  ## Only logged in users can delete their feeds
  def destroy
    @feed.destroy
    redirect_to feeds_path, alert: Message.feed_destroyed
  end

  ## PATCH /feeds/:id/public
  ## Only logged in users can make this feed public
  def public
    @feed.update_attribute(:public, true)
    redirect_to feeds_path, notice: Message.feed_public
  end

  ## PATCH /feeds/:id/private
  ## Defaults by private itself
  ## Only logged in users can make this feed private
  def private
    @feed.update_attribute(:public, false)
    redirect_to feeds_path, notice: Message.feed_private
  end

  private
    ## Set the feed, DRY
    def set_feed
      @feed = Feed.find(params[:id])
    end

    ## Whitelist params for feeds, anything else will be rejected
    def feed_params
      params.require(:feed).permit(:content)
    end

    ## Decrypt the content before showing it to users
    def decrypt_feed
      @feed.content = Encryption.decrypt_data(@feed.content)
    end

    ## Make the API call for moderation, then send the results back as success, error
    def content_moderation(content)
      url = ENV["content_moderation_url"]
      uri = URI(url)

      ## Add empty arrays: Error and Success
      error = []
      success = []

      request = Net::HTTP::Post.new(uri.request_uri)
        
      # Request headers
      request['Content-Type'] = ' text/plain'
      request['Ocp-Apim-Subscription-Key'] = ENV["content_moderation_api_key"]
      
      # Request body
      request.body = content

      begin
        response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
          http.request(request)
        end
      rescue StandardError => e
        error << Message.api_error
        return success, error
      end

      response_body = JSON.parse(response.body)

      if response_body["error"]
        error << response_body["error"]["message"]
      end

      if response_body["PII"]
        success << Message.pii_info_found
      end

      if response_body["Terms"]
        success << Message.abuse_found
      end

      return success, error
    end
end
