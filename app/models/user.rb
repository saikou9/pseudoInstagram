class User < ApplicationRecord
  before_save { email.downcase! }
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name,     presence: true,    length: { minimum:3,    maximum: 30 }
  validates :email,    presence: true,    length: { minimum:6,    maximum: 50 },
                                          format: { with:         EMAIL_REGEX },
                                          uniqueness: true
  has_secure_password
  validates :password, presence: true,    length: { minimum: 5 }
end