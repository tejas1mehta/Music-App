module ApplicationHelper


  def current_user
    @current_user ||= User.find_by_session_token(session[:session_token]) #Session.find_by_session_token(session[:session_token]).try(:user)
  end

  def auth_token_html
    "<input type='hidden' name='authenticity_token'
        value='#{form_authenticity_token}'>".html_safe
  end

  def logged_in?
    !!current_user
  end

  def admin_log_in?
    !current_user.nil? && current_user.admin
  end

end
