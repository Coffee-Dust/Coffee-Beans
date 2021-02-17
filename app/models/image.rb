class Image < ActiveRecord::Base
  belongs_to :post
  has_one_attached :attachment
  validates_presence_of :attachment
end