class User < ApplicationRecord
  validates :password_confirmation, presence: true
  has_secure_password
end
