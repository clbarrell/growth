# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def welcome_email
    UserMailer.welcome_email(User.first)
  end

  def first_checkin
    UserMailer.first_checkin(User.first, User.first.goals.first)
  end

  def access_to_new_goal
    UserMailer.access_to_new_goal(User.first, Goal.last, User.third)
  end

  def please_set_password
    UserMailer.please_set_password(User.first, Goal.last, User.third)
  end
end
