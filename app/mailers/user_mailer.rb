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

  def access_to_new_goal(user, goal, goal_owner)
    # you have access to a new goal
    @current_user = user
    @goal = goal
    @goal_owner = goal_owner
    @url_link = checkin_answers_goal_url(goal)
    mail(to: @current_user.email, subject: "Someone gave you access to their goal!")
  end

  def please_set_password(user, goal_to_access, goal_owner)
    # someone gave you a goal, please set up PW
    @current_user = user
    @goal = goal_to_access
    @goal_owner = goal_owner
    @url_link = new_user_password_url
    mail(to: @current_user.email, subject: "Someone gave you access to their growth-focus goal!")
  end

end
