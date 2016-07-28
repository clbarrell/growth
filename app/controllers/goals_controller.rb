class GoalsController < ApplicationController
  before_action :set_goal, only: [:show, :edit, :update, :destroy, :update_checkin]


  # GET /goals
  # GET /goals.json
  def index
    @goals = Goal.all
  end

  # GET /goals/1
  # GET /goals/1.json
  def show
    @goal = Goal.find(params[:id])
    @checkin_questions = @goal.checkin_questions
    @review_questions = @goal.review_questions
  end

  # GET /goals/new
  def new
    @goal = Goal.new
  end

  # goals/1/checkin
  def checkin
    # view for checkin
    @goal = Goal.find(params[:id])
    @ac_questions = @goal.actual_questions.checkins

  end

  def checkin_successful
    # NOT USING THIS
    # when checknin is successfull
    @goal = Goal.find(params[:id])

  end

  def update_checkin
    # for receiving checkin params

    Rails.logger.debug params.inspect
    #@goal = Goal.new(goal_params)
    # eventually use 'current_user'
    #@goal.user = User.find(1)

    respond_to do |format|
      if @goal.update(goal_params)
        @goal.new_checkin
        format.html { redirect_to checkin_goal_url(params[:id])}
        # if params.comment_answer.present? then redirect to whereve
        # we want the checkin to goafterwards
        format.json { render :checkin_successful, status: :ok, location: @goal }
      else
        format.html { render :checkin }
        format.json { render json: @goal.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /goals/1/edit
  def edit
  end

  # POST /goals
  # POST /goals.json
  def create
    @goal = Goal.new(goal_params)
    # eventually use 'current_user'
    @goal.user = User.find(1)
    respond_to do |format|
      if @goal.save
        format.html { redirect_to @goal, notice: 'Goal was successfully created.' }
        format.json { render :show, status: :created, location: @goal }
      else
        format.html { render :new }
        format.json { render json: @goal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /goals/1
  # PATCH/PUT /goals/1.json
  def update
    Rails.logger.debug params.inspect
    respond_to do |format|
      if @goal.update(goal_params)
        format.html { redirect_to @goal, notice: 'Goal was successfully updated.' }
        format.json { render :show, status: :ok, location: @goal }
      else
        format.html { render :edit }
        format.json { render json: @goal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /goals/1
  # DELETE /goals/1.json
  def destroy
    @goal.destroy
    respond_to do |format|
      format.html { redirect_to goals_url, notice: 'Goal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_goal
      @goal = Goal.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def goal_params
      params.require(:goal).permit(:title, :description, :frequency, :goaltype, :user_id,
      rating_answers_attributes: [:id, :answer],
      comment_answers_attributes: [:id, :answer],
      boolean_answers_attributes: [:id, :answer])
    end
end
