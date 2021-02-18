class CommentsController < ApplicationController
  before_action :logged_in_or_redirect

  def create
    @post = Post.find_by(id: comment_params[:post_id])
    @comment = Comment.new(content: comment_params[:content], post: @post)
    @comment.user = current_user

    if @post && @comment.save
      redirect_to user_post_path(@post.user, @post)
    else
      flash[:comment_error] = true
      redirect_to user_post_path(@post.user, @post)
    end
  end

  def destroy
    @comment = Comment.find_by(id: params[:id])
    if @comment && @comment.user == current_user
      @comment.destroy
      flash[:notice] = "Comment Deleted"
      redirect_to user_post_path(@comment.post.user, @comment.post)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:id, :content, :post_id)
  end

end
