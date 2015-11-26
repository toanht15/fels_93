class User < ActiveRecord::Base
  has_many :activities
  has_many :lessons
  has_many :categories, through: :lessons
  has_secure_password

  validates :name,  presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: 6}

  before_save :downcase_email

  private
  def downcase_email
    self.email = email.downcase
  end
end
