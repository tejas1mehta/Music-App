class UsersController < ApplicationController
  before_action :ensure_admin!, only: :index

  def index
    @users = User.all

    render :index
  end

  def new
    @user = User.new

    render :new
  end

  def create
    user = User.new(user_params)

    if user.save!
      msg = UserMailer.welcome_email(user)
      msg.deliver!
      redirect_to new_session_url
      # log_in(user)
    else
      flash[:errors] = [user.errors.full_messages]
      redirect_to new_user_url
    end

  end

  def show
    @user = current_user
    render :show
  end

  def activate
    user = User.find_by_activation_token(params[:activation_token])

    if user && params[:activation_token]
      user.activated = true
      log_in(user)
    else
      flash.now[:errors] = ["Record not found."]
      redirect_to new_user_url
    end
  end

  def toggleboolean
    User.find(params[:user_change].to_i).toggle!(:admin)

    redirect_to users_url
  end


  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
