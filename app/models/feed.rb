class Feed < ApplicationRecord
  belongs_to :user

  before_save :encrypt_feed

  ## Make content validation
  validates :content, presence: true, length: { minimum: 10, maximum: 500 }
  ## User's email must be confirmed to accept feedback
  ## This check is done at controller level, but for more security
  ## done at model level also
  validate :user_confirmed?, on: :create

  private
    ## Encrypt the content before saving/updating to DB
    def encrypt_feed
      self.content = Encryption.encrypt_data(self.content)
    end

    ## If someone tired to submit a feedback for a user whose email is not confirmed
    ## Throw an error
    def user_confirmed?
      errors.add(:user, Message.user_email_not_confirmed) unless self.user && self.user.confirmed?
    end
end
