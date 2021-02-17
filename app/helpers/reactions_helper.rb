module ReactionsHelper

def user_has_reacted_with_type?(type, parent)
    @last_parent_class ||= parent.class
    if parent.class == @last_parent_class
      @user_reaction_types ||= current_user ? parent.reactions.from_user(current_user).map(&:reaction_type) : []
    else
      @user_reaction_types = current_user ? parent.reactions.from_user(current_user).map(&:reaction_type) : []
    end
    @last_parent_class = parent.class
    @user_reaction_types.include?(type) ? true : false
  end

end