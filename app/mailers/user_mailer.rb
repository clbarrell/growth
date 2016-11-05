class UserMailer < ApplicationMailer

  def welcome_email(user)
    @user = user
    @url_link = new_goal_url
    mail(to: @user.email, subject: 'Welcome to growth-focus!')
  end
end
