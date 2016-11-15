class SocialGoalRecordsController < ApplicationController
  before_action :set_social_goal_record, only: [:show, :edit, :update, :destroy]

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

  # POST /social_goal_records
  # POST /social_goal_records.json
  def create
    @social_goal_record = SocialGoalRecord.new(social_goal_record_params)
    @social_goal_record.user = current_user
    @social_goal_record.goal_owner = @social_goal_record.goal.user
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
    @social_goal_record.destroy
    respond_to do |format|
      format.html { redirect_to social_goal_records_url, notice: 'Social goal record was successfully destroyed.' }
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
      params.require(:social_goal_record).permit(:user_id, :goal_id)
    end
end
