class UserMailer < ApplicationMailer

  def welcome_email(user)
    @user = user
    @url  = 'https://growth-focus.herokuapp.com/'
    mail(to: @user.email, subject: 'Welcome to growth-focus!')
  end
end
