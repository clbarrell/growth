class UserMailer < ApplicationMailer

  def welcome_email(user)
    @user = user
    @url_link = new_goal_url
    mail(to: @user.email, subject: 'Welcome to growth-focus!')
  end

  def first_checkin(user, goal)
    # congrats on first checkin
    @user = user
    @goal = goal
    @url_link = checkin_goal_url(goal)
    mail(to: @user.email, subject: "Nice work on that check in!")
    #delay(run_at: 5.minutes.from_now)
  end

  
end
