class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: params[:user][:email])
    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect_to(root_path)
    else
      @user = User.new(email: params[:user][:email])
      flash[:alert] = "Couldn't find that account fewl."
      render :new
    end
  end

  def omni_auth_create
    if request.env['omniauth.auth']
      @user = User.find_or_create_by_oauth(request.env['omniauth.auth'])
      session[:user_id] = @user.id
      redirect_to(root_path)
    else
      flash[:alert] = "Something went wrong with the third-party login."
      redirect_to(login_path)
    end
  end

  def destroy
    reset_session
    redirect_to(login_path)
  end
end