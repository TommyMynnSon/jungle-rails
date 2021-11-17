class User < ActiveRecord::Base

  has_secure_password

  validates :password, length: { minimum: 2 }
  validates :password_confirmation, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :name, presence: true
 
end
