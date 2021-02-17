module ReactionsHelper

  def user_has_reacted_with_type?(type, parent)
    @user_reaction_types ||= current_user ? parent.reactions.from_user(current_user).map(&:reaction_type) : []
    @user_reaction_types.include?(type) ? true : false
  end

end