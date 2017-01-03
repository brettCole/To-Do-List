class User < ActiveRecord::Base
  has_secure_password
  has_many :tasks
  has_many :lists
  validates :username, :email, :password, presence: true
  validates :username, :email, uniqueness: true
end
