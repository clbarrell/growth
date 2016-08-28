class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
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
end
