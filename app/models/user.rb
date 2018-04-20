class User < ActiveRecord::Base
  has_secure_password
  before_validation :downcase_email
  # before_action :require_login, except: [:new, :create]
  # before_action :require_correct_user, only: [:show, :edit, :update, :destroy]
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  has_secure_password
  validates :name,:alias,presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: {with: EMAIL_REGEX}
  validates :password, length: { minimum: 8 }, on: :create
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :posts_liked, through: :likes, source: :post
  def downcase_email
    self.email = email.downcase if email.present?
  end 
end
