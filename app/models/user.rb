class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :trackable

  has_many :feeds, dependent: :destroy
  has_many :reports

  # OTP Token
  has_one_time_password
  enum otp_module: { disabled: 0, enabled: 1 }, _prefix: true
  attr_accessor :otp_code_token

  # Username
  USERNAME_REGEX = /\A[a-z0-9\_]+\z/i

  validates :username, uniqueness: { case_sensitive: true }, presence: true, length: { minimum: 3, maximum: 10 }, format: { with: USERNAME_REGEX, multiline: true }
  validates_inclusion_of :admin, in: [true, false]

  before_save :downcase_username

  private
    def downcase_username
      self.username = self.username.downcase if self.username
    end
end
