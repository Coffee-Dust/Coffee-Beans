class ReactionsController < ApplicationController
  before_action :logged_in_or_redirect

  def react_or_remove

    find_or_build_reaction #assigns @reaction

    if @reaction.persisted?
      # If it is persisted, then it already exists and must be destroyed!
      self.destroy
    else
      self.create
    end
  end

  def create

    if @reaction.reactable && @reaction.save
      redirect_to_reactable
    else
      render plain: "This should never be called. Like seriously if your seeing this something went really wrong", status: 569
    end
  end

  def destroy
    @reaction.destroy
    redirect_to_reactable
  end

  private
  def reaction_params
    params.require(:reaction).permit(:reaction_type, :user, :reactable_id, :reactable_type)
  end

  def redirect_to_reactable
    case @reaction.reactable.class.to_s
    when "Post"
      redirect_to(user_post_path(@reaction.reactable.user, @reaction.reactable))
    when "Comment"
      redirect_to(user_post_path(@reaction.reactable.post.user, @reaction.reactable.post))
    else
      raise "Error in redirect to reactable class; Class invalid: #{@reaction.reactable.class.to_s}"
    end
  end

  def find_or_build_reaction
    new_reaction = Reaction.new(reaction_params)
    new_reaction.user = current_user
    users_posts_reactions = Reaction.find_reactions_for_user_on_reactable(current_user, new_reaction.reactable)

    if users_posts_reactions.present? && existing_reaction = users_posts_reactions.of_type(new_reaction.reaction_type)
      # The reaction already exists. Assigning it to class var 
      # so it can be killed with fire
      @reaction = existing_reaction
    else
      # Assigning the already built reaction to class var
      @reaction = new_reaction
    end
  end

end
