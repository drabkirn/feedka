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
  def new
    ## Pick the user by username params
    ## If user is not found, redirect to root_path with alert message
    user = User.find_by(username: params[:username])
    redirect_to root_path, alert: Message.user_not_found if !user

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
      ## Send the feedback from 10 - 300 mins later generated randomly
      generate_mins = rand(10..300)
      FeedSaveJob.set(wait: generate_mins.minutes).perform_later(@feed.user.id, @feed.content)
      redirect_to root_path, notice: Message.feed_created
    else
      redirect_to ref_path, alert: @feed.errors
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
end
