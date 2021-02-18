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

  def self.number_of_type(type)
    self.where(reaction_type: type).count
  end

  def self.find_or_build_reaction_with(reaction_params, current_user)
    new_reaction = Reaction.new(reaction_params)
    new_reaction.user = current_user
    users_posts_reactions = Reaction.find_reactions_for_user_on_reactable(current_user, new_reaction.reactable)

    if users_posts_reactions.present? && existing_reaction = users_posts_reactions.of_type(new_reaction.reaction_type)
      # The reaction already exists. Assigning it to class var 
      # so it can be killed with fire
      return existing_reaction
    else
      # Assigning the already built reaction to class var
      return new_reaction
    end
  end

end