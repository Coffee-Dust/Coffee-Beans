class Reaction < ActiveRecord::Base
  belongs_to :reactable, polymorphic: true
  belongs_to :user

  validates_presence_of :reaction_type, :reactable_id, :reactable_type, :user

  scope :from_user, ->(user) { where(user_id: user.id) }

  REACTION_TYPES = [
    "like",
    "dislike",
    "love",
    "laugh",
    "angry",
    "sad"
  ]

  def type
    self.reaction_type
  end

  def self.all_types
    REACTION_TYPES
  end

  def self.find_reactions_for_user_on_reactable(user, reactable)
    self.where(reactable: reactable).where(user: user)
  end

  def self.of_type(type)
    self.find_by(reaction_type: type)
  end
end