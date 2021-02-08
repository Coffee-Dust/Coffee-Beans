class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  has_many :commented_posts, through: :comments, source: :post
  
  has_secure_password

  validates_presence_of :name, :email, :password
  validates :password, confirmation: {case_sensitive: true}
  validates :email, uniqueness: {message: "Email already taken!"}
end