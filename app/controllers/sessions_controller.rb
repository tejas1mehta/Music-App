class SessionsController < ApplicationController

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(params["user"]["email"],params["user"]["password"])
    #current_user #User.find_by_credentials()# parameters
    if @user
       log_in(@user)
    else
       flash.now[:errors] = ["Incorrect username/password"]
       render :new
     end
  end

  def destroy
    current_user.reset_token_password!
    session[:session_token] = nil

    redirect_to new_session_url
  end

end
