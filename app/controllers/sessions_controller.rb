class SessionsController < ApplicationController
  
  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: params[:user][:email])
    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect_to(home_path)
    else
      @user = User.new(email: params[:user][:email])
      flash[:alert] = "Couldn't find that account fewl."
      render :new
    end
  end

  def destroy
    reset_session
    redirect_to(login_path)
  end
end