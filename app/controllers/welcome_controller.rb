class WelcomeController < ApplicationController

  def home
    if logged_in?
      redirect_to(posts_path)
    else
      redirect_to(login_path)
    end
  end

  def profile
    if logged_in?
      redirect_to(user_path(current_user))
    else
      redirect_to(login_path)
    end
  end

end