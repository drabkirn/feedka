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
end