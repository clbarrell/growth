class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # GET /questions
  # GET /questions.json
  def index
    @goal = Goal.find(params[:goal_id])
    @checkin_questions = @goal.checkin_questions
    @review_questions = @goal.review_questions
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
    @question = Question.find(params[:id])
  end

  # GET /questions/new
  # GET /goals/:goal_id/questions/new(.:format)
  def new
    @question = Question.new
    @goal = Goal.find(params[:goal_id])
    # new_goal_question is HELPER
  end

  # GET /questions/1/edit
  def edit

  end

  def increase
      # increase question order
      @question = Question.find(params[:id])
      @goal = @question.goal
      # find maximum
      @max_qn_order = @goal.checkin_questions.maximum(:qnorder)
      if @question.qnorder == 1 || @question.qnorder == @max_qn_order
          redirect_to goal_path(@question.goal.id), notice: 'Error: order is already at start or maximum.'
      else
          @question.increase_order
          redirect_to goal_path(@question.goal.id), notice: 'Order successfully changed.'
      end
      # end with a redirect
  end

  def decrease
      # increase question o`rder
      @question = Question.find(params[:id])
      @goal = @question.goal
      # find maximum
      @max_qn_order = @goal.checkin_questions.maximum(:qnorder)
      if @question.qnorder == 1 || @question.qnorder == @max_qn_order
          redirect_to goal_path(@question.goal.id), notice: 'Error: order is already at start or maximum.'
      else
          @question.decrease_order
          redirect_to goal_path(@question.goal.id), notice: 'Order successfully changed.'
      end
      # end with a redirect`
  end


  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)
    @question.set_default_order if @question.qnorder.nil?
    respond_to do |format|
      if @question.save
        format.html { redirect_to goal_questions_url(@question.goal), notice: 'Question was successfully created.' }
        format.json { render :index, status: :created }
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to goal_url(@question.goal), notice: 'Question was successfully updated.' }
        format.json { render :show, status: :ok, location: @question.goal }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to goal_url(@question.goal), notice: 'Question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
      @goal = @question.goal
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:question, :qntype, :scale, :qnorder, :goal_id)
    end
end
