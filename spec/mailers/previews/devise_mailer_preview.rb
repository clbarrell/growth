# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class DeviseMailerPreview < ActionMailer::Preview
  def reset_password_instructions
    Devise::Mailer.reset_password_instructions(User.first, 12481242, {})
  end
end
