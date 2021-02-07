class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :reactions, as: :reactable
  has_many :users_who_commented, through: :comments, source: :user
end