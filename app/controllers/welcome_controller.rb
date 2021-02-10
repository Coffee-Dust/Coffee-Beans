class WelcomeController < ApplicationController
  def home
    redirect_to(login_path)
  end
end