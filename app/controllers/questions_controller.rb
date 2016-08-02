class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  # GET /questions
  # GET /questions.json
  def index
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
    @question = Question.find(params[:id])
  end

  # GET /questions/new
  def new
    @question = Question.new
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
        format.html { redirect_to questions_url, notice: 'Question was successfully created.' }
        format.json { render :index, status: :created, location: @question }
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
        format.html { redirect_to questions_url, notice: 'Question was successfully updated.' }
        format.json { render :index, status: :ok, location: @question }
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
      format.html { redirect_to questions_url, notice: 'Question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:question, :qntype, :scale, :qnorder, :goal_id)
    end
end
