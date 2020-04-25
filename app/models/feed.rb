class Feed < ApplicationRecord
  belongs_to :user

  before_save :encrypt_feed

  ## Make content validation
  validates :content, presence: true, length: { minimum: 10, maximum: 500 }

  private
    ## Encrypt the content before saving/updating to DB
    def encrypt_feed
      self.content = Encryption.encrypt_data(self.content)
    end
end
