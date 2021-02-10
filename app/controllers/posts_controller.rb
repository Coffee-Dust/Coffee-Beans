class PostsController < ApplicationController

  def index
  end

  def show
  end

  def new
    if logged_in?
      @post = Post.new
      render :new
    else
      redirect_to(login_path)
    end
  end

  def create
    if logged_in?
      @post = Post.new(content: post_params[:content], user: current_user)
      if @post.save
        redirect_to(user_post_path(current_user, @post))
      else
        render :new
      end
    else
      redirect_to(login_path)
    end
  end

  def edit

  end
  
  def update

  end

  def destroy
    
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
