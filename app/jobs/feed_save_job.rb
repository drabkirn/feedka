class FeedSaveJob < ApplicationJob
  queue_as :default

  def perform(user_id, content)
    feed = Feed.new
    feed.user_id = user_id
    feed.content = content
    feed.save
  end
end
