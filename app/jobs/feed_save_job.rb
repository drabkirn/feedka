class FeedSaveJob < ApplicationJob
  queue_as :default

  def perform(user_id, encrypted_content)
    content = Encryption.decrypt_data(encrypted_content)

    feed = Feed.new
    feed.user_id = user_id
    feed.content = content
    feed.save
  end
end
