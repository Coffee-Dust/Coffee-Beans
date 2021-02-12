class Reaction < ActiveRecord::Base
  belongs_to :reactable, polymorphic: true
  belongs_to :user

  validates_presence_of :reaction_type, :reactable_id, :reaction_type, :user
end