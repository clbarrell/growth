class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    # resource == user
    sign_in_url = new_user_session_url
    google_signin_url = user_google_oauth2_omniauth_authorize_url
    if request.referer == sign_in_url || request.referer == google_signin_url || request.referer == new_user_registration_url
      super
      goals_path
    else
      request.referer || root_path
    end
  end
# request.referer == http://localhost:3000/users/auth/google_oauth2 when google
# signin url == http://localhost:3000/users/sign_in
# singin url all good when signing in

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end
end
