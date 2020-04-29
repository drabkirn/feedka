class Message
  # Custom Messages that can be used application-wide

  ## Feeds messages
  def self.feed_created
    "Yayay! Your feedback was successfully sent."
  end

  def self.feed_public
    "Your requested feedback went into public mode, you can anytime make it back to private."
  end

  def self.feed_private
    "Your requested feedback went back into private mode, you can anytime make it public."
  end

  def self.feed_destroyed
    "Requested feedback has been destroyed."
  end

  ## Users messages
  def self.user_not_found
    "No user was found with this username, please try again."
  end

  def self.user_email_not_confirmed
    "This account is not yet activated. Email associated is not yet confirmed."
  end

  def self.require_admin
    "You must be admin to perform this request."
  end

  ## Content moderation messages
  def self.pii_info_found
    "You need to wait!!! You've tried to send some Personal Identifiable Information[PII] which may include your phone number or email or home address. Our goal is to keep your feedback anonymous, so we had to reject your feedback. Please try again without adding any PII data, and if the problem persists, submit us a report below!"
  end

  def self.abuse_found
    "That was not expected from you!!! Our system has detected that you've tried to abuse while giving your feedback. Our goal is to keep feedbacks abuse-free, so we had to reject your feedback. Please try again without abusing, and if the problem persists, submit us a report below!"
  end

  ## Report messages
  def self.report_created
    "Your report was successfully submitted, bookmark this page and keep visiting this page to see the status of your report."
  end

  def self.feed_content_not_found
    "You tried to submit the report with invalid. Please try again and if the problem persists, shoot us an email at #{ENV["mailer_from_address"]}"
  end

  ## 2FA related messages
  def self.two_fa_empty
    "You've two factor enabled for your account, so you'll need to enter your token while signing in. If you've no access to your OTP, shoot us an email at #{ENV["mailer_from_address"]}"
  end

  def self.two_fa_wrong
    "You've entered wrong 2FA code, please try again and if the problem persists, shoot us an email at #{ENV["mailer_from_address"]}"
  end
  
  def self.two_fa_enabled
    "Yayay! Two factor authentication has been successfully enabled for your account, now you'll need to input token to access your account. Your account is now more secure."
  end

  def self.two_fa_not_enabled
    "We're sorry, we couldn't enable two factor authentication to your account. Please try again and if the problem persists, shoot us an email at #{ENV["mailer_from_address"]}"
  end

  def self.two_fa_disabled
    "Woooo! Two factor authentication has been successfully disabled for your account. This has now reduced your account security."
  end

  def self.two_fa_not_disabled
    "We're sorry, we couldn't disable two factor authentication to your account. Please try again and if the problem persists, shoot us an email at #{ENV["mailer_from_address"]}"
  end

  ## Other messages
  def self.api_error
    "There is something wrong with our API, don't worry, this problem is from our end. Please try again and if the problem persists, shoot us an email at #{ENV["mailer_from_address"]}"
  end

  def self.ip_throttled_body
    "You're not permitted to perform such actions frequently, please try again after some time."
  end
end