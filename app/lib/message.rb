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

  ## Content moderation messages
  def self.pii_info_found
    "You need to wait!!! You've tried to send any Personal Identifiable Information[PII] which may include your phone number or email or address. Our goal is to keep your feedback anonymous, so we had to reject your feedback. Please try again without adding any PII data, and if the problem persists, shoot us an email at #{ENV["mailer_from_address"]}"
  end

  def self.abuse_found
    "That was not expected from you!!! Our system has detected that you've tried to abuse while giving your feedback. Our goal is to keep feedbacks abuse-free, so we had to reject your feedback. Please try again without adding any PII data, and if the problem persists, shoot us an email at #{ENV["mailer_from_address"]}"
  end

  ## Other messages
  def self.api_error
    "There is something wrong with our API, don't worry, this problem is from our end. Please try again and if the problem persists, shoot us an email at #{ENV["mailer_from_address"]}"
  end

  def self.ip_throttled_body
    "You're not permitted to perform such actions frequently, please try again after some time."
  end

end