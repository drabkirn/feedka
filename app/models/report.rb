class Report < ApplicationRecord
  belongs_to :user
  before_save :encrypt_feed

  enum status: { pending: 0, rejected: 1, accepted: 2 }, _prefix: true

  ## Make content validation
  ## Same as Feed content validation
  validates :content, presence: true, length: { minimum: 10, maximum: 500 }
  validates :message, length: { maximum: 500 }
  ## Make status validation
  validates :status, presence: true

  private
    ## Encrypt the content before saving/updating to DB
    def encrypt_feed
      self.content = Encryption.encrypt_data(self.content)
    end
end
