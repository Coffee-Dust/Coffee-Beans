class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  has_many :reactions, as: :reactable
end