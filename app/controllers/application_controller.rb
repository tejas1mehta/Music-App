class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include ApplicationHelper

  def log_in(user)
    #xcurrent_user = user # write current user
    if user.activated
      session[:session_token] = user.reset_token_password!
      redirect_to user_url(user)
    else
      flash[:errors] = [" Account not activated"]
      redirect_to new_user_url
    end
  end

  def ensure_admin!
      redirect_to root_url unless current_user.admin
  end
end
