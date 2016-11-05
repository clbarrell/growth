class HomeController < ApplicationController
  def home
    # Redirect if logged in?
    if user_signed_in?

      url = request.referrer
      if url.include?('growth-focus')
        redirect_to(goals)
      else
        #render :layout => 'layout'
      end
    end
  end

  def help
  end
end
