class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def welcome_email(user)
    @user = user
    #@url  = "localhost:3000/users/activate?activation_token=#{user.activation_token}"
    mail(to: user.email, subject: 'Welcome to My Awesome Site')
  end

end
