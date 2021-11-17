class User < ActiveRecord::Base

  has_secure_password

  validates :password_confirmation, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
 
end
