class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  has_many :commented_posts, through: :comments, source: :post
  
  has_secure_password

  validates_presence_of :name, :email, :password
  validates :password, confirmation: {case_sensitive: true}
  validates :email, uniqueness: {message: "Email already taken!"}

  def self.find_or_create_by_oauth(oauth_hash)
    self.find_or_create_by(email: oauth_hash['info']['email']) do |user|
      user.name = oauth_hash['info']['name']
      user.password = SecureRandom.hex
    end
  end
end