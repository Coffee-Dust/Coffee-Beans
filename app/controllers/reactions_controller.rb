class ReactionsController < ApplicationController
  before_action :logged_in_or_redirect

  def create
    # raise params.inspect
    @reaction = Reaction.new(reaction_params)
    @reaction.user = current_user
    if @reaction.reactable && @reaction.save
      redirect_to_reactable
    else
      render plain: "This should never be called. Like seriously if your seeing this something went really wrong", status: 569
    end
  end

  def destroy
    
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

end
