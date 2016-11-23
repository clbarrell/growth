class SocialGoalRecordsController < ApplicationController
  before_action :set_social_goal_record, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /social_goal_records
  # GET /social_goal_records.json
  def index
    @social_goal_records = SocialGoalRecord.where(user: current_user)
    @goals = current_user.goals

    @user = current_user
    @social_goals = @user.social_goals
    @goal_owners = @user.goal_owners
  end

  # GET /social_goal_records/1
  # GET /social_goal_records/1.json
  def show
  end

  # GET /social_goal_records/new
  def new
    @social_goal_record = SocialGoalRecord.new(user: current_user)
  end

  # GET /social_goal_records/1/edit
  def edit
  end

  # post
  def new_social_goal
    @social_goal_record = SocialGoalRecord.new()
    @social_goal_record.goal = Goal.find(params[:goal_id])
    @social_goal_record.goal_owner = @social_goal_record.goal.user
      if User.exists?(email: params[:email])
        @social_goal_record.user = User.find_by(email: params[:email])
        # send the "you've got a new goal email"
        UserMailer.access_to_new_goal(@social_goal_record.user,
                                      @social_goal_record.goal,
                                      @social_goal_record.goal_owner).deliver_later
      else
        # create user
        user = User.create(email: params[:email],
                    password: Devise.friendly_token[0,20])
        @social_goal_record.user = user
        # send email "new goal access - please set up account"
        UserMailer.please_set_password(@social_goal_record.user,
                                      @social_goal_record.goal,
                                      @social_goal_record.goal_owner).deliver_later
      end
    respond_to do |format|
      # create sgr
      if @social_goal_record.save
        format.html { redirect_to social_goal_path(params[:goal_id]), notice: @social_goal_record.user.email.concat(" was given access to this goal.") }
      else
        format.html { redirect_to social_goal_path(params[:goal_id]), notice: "Error. Social record wasn't able to be created." }
      end
    end
  end


  # POST /social_goal_records
  # POST /social_goal_records.json
  def create
    @social_goal_record = SocialGoalRecord.new(social_goal_record_params)
    @social_goal_record.goal_owner = @social_goal_record.current_user
    respond_to do |format|
      if @social_goal_record.save
        format.html { redirect_to @social_goal_record, notice: 'Social goal record was successfully created.' }
        format.json { render :show, status: :created, location: @social_goal_record }
      else
        format.html { render :new }
        format.json { render json: @social_goal_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /social_goal_records/1
  # PATCH/PUT /social_goal_records/1.json
  def update
    respond_to do |format|
      if @social_goal_record.update(social_goal_record_params)
        format.html { redirect_to @social_goal_record, notice: 'Social goal record was successfully updated.' }
        format.json { render :show, status: :ok, location: @social_goal_record }
      else
        format.html { render :edit }
        format.json { render json: @social_goal_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /social_goal_records/1
  # DELETE /social_goal_records/1.json
  def destroy
    goal = @social_goal_record.goal
    @social_goal_record.destroy
    respond_to do |format|
      format.html { redirect_to social_goal_path(goal), notice: 'Social goal record was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_social_goal_record
      @social_goal_record = SocialGoalRecord.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def social_goal_record_params
      params.require(:social_goal_record).permit(:user_id, :goal_id, :email)
    end
end
