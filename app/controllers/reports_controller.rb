class ReportsController < ApplicationController
  
  ## GET /reports/:id
  def show
    @report = Report.find(params[:id])
  end

  ## GET /r/:username
  ## Anyone can use this link and submit report
  def report
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

    ## Get the `feed_content` param
    @feed_content = params[:feed_content]

    ## If `feed_content` param is not found, redirect to root path with alert
    if !@feed_content
      redirect_to root_path, alert: Message.feed_content_not_found
      return
    end

    @report = Report.new
  end

  ## POST /reports
  def create
    @report = Report.new(report_params)

    ## We cannot use `user_id` as hidden field in forms
    ## So this workfix, helps get the username
    ref_path = URI(request.referer).path
    username = ref_path.split("/").last
    user = User.find_by(username: username)

    ## Now set the user
    ## If user is somehow not set, Feed won't save and returns the error to view
    @report.user = user if user

    if @report.save
      redirect_to report_path(@report.id), notice: Message.report_created
    else
      redirect_to ref_path, alert: Message.feed_content_not_found
    end
  end

  private
    ## Whitelist params for reports, anything else will be rejected
    def report_params
      params.require(:report).permit(:content)
    end
end
