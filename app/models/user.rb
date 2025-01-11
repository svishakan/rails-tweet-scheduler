# email:string
# password_digest:string
# password:string -- virtual attribute
# password_confirmation:string -- virtual attribute

class User < ApplicationRecord
  has_secure_password # Add a password & password confirmation attribute, uses bcrypt

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "Must be a valid email address" }

  validates :password, presence: true
end
