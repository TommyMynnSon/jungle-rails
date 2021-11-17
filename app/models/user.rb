class User < ActiveRecord::Base

  has_secure_password

  validates :password_confirmation, presence: true
  validates :email, presence: true
  validates_uniqueness_of :email

end
