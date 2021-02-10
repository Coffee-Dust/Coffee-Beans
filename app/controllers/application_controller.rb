class ApplicationController < ActionController::Base
  helper_method :current_user

  def logged_in?
    !!current_user
  end

  def logged_in_or_redirect
    redirect_to(login_path) if !logged_in?
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
end
