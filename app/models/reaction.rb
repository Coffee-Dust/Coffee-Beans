class Reaction < ActiveRecord::Base
  belongs_to :reactable, polymorphic: true
  belongs_to :user

  validates_presence_of :reaction_type, :reactable_id, :reactable_type, :user

  scope :from_user, ->(user) { where(user_id: user.id) }

  # Magic Numbers Definition - ITS MAGIC
  REACTION_TYPES = {
    1 => :like,
    2 => :dislike,
    3 => :love,
    4 => :laugh,
    5 => :angry,
    6 => :sad
  }

  def type
    REACTION_TYPES[self.reaction_type]
  end

  def self.find_reactions_for_user_on_reactable(user, reactable)
    self.where(reactable: reactable).where(user: user)
  end

  def self.of_type(type)
    self.find_by(reaction_type: type)
  end
end