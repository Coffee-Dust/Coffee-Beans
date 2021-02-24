class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :reactions, as: :reactable
  has_many :users_who_commented, through: :comments, source: :user
  has_one :image
  validates_presence_of :content, :user_id

  scope :search, ->(query_string) {self.where("content LIKE ?", "%#{query_string}%")}

  accepts_nested_attributes_for :image
end