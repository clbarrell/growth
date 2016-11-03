class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authorise_user, only: [:show, :edit, :update]


  def index
    if current_user.email == "clbarrell@gmail.com"
      @users = User.all
    else
      redirect_to goals_path, alert: "You don't have access to this section."
    end
  end

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save # when save is successful
      UserMailer.welcome_email(@user).deliver_later
      flash["notice"] = "New user created."
      redirect_to goals_path
    else
      render "new"
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params) # when save is successful
      flash["notice"] = "User successfully updated."
      redirect_to @user
    else
      render "new"
    end
  end


  private

    def user_params
      params.require(:user).permit(:name, :email, :password)
    end

    # ensure the user is correct
    def authorise_user
      if params[:id].to_i != current_user.id
        redirect_to goals_path, alert: "You don't have access to this section."
      end
    end
end
