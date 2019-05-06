class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@event-bro.com'
  layout 'mailer'

  def welcome_user(user)
    @user = user
    @url = "https://event-bro.herokuapp.com/"

    mail(to: @user.email, subject: "Welcome to EventBro !")
  end


end
