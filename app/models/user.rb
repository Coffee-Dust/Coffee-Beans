class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  has_many :commented_posts, through: :comments, source: :post
  has_secure_password
end