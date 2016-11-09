# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def welcome_email
    UserMailer.welcome_email(User.first)
  end

  def first_checkin
    UserMailer.first_checkin(User.first, User.first.goals.first)
  end
end
