class UserMailer < ActionMailer::Base
  default from: 'no-reply@event-bro.com'


  def welcome_email(user)
    @user = user
    @url = "https://event-bro.herokuapp.com/"

    mail(to: @user.email, subject: "Welcome to EventBro !")
  end

end
