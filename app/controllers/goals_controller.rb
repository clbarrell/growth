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
    @questions = @goal.checkin_questions


  end

  def reset
    # to reset all the goal's questions
    @goal = Goal.find(params[:id])
    @goal.questions.delete_all
    @goal.create_default_questions

    respond_to do |format|
      format.html { redirect_to @goal }
      # if params.comment_answer.present? then redirect to whereve
      # we want the checkin to goafterwards
      format.json { render :show, status: :ok, location: @goal }
    end
  end

  def update_checkin
    # for receiving checkin params

    Rails.logger.debug params.inspect
    @goal = Goal.find(params[:id])
    # eventually use 'current_user'
    #@goal.user = User.find(1)

    respond_to do |format|
      if @goal.update(goal_params)
        @goal.new_checkin
        format.html { redirect_to checkin_goal_url(params[:id])}
        # if params.comment_answer.present? then redirect to whereve
        # we want the checkin to goafterwards
        format.json { render :checkin, status: :ok, location: @goal }
      else
        format.html { render :checkin }
        format.json { render json: @goal.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /goals/1/edit
  def edit
  end

  def undo_checkin
    @goal = Goal.find(params[:id])
    @goal.undo_checkin
    respond_to do |format|
      format.html { redirect_to checkin_goal_url(params[:id]), notice: 'Check in was un done' }
      format.json { render :checkin }
    end
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
        questions_attributes: [:id, :question,
          rating_answers_attributes: [:id, :answer, :question_id],
          comment_answers_attributes: [:id, :answer, :question_id],
          boolean_answers_attributes: [:id, :answer, :question_id]
        ])
    end
end
