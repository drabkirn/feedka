class Feed < ApplicationRecord
  belongs_to :user

  ## Make content validation
  validates :content, presence: true, length: { minimum: 10, maximum: 500 }
end
