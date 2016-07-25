class ActualQuestionsController < ApplicationController
  before_action :set_actual_question, only: [:show, :edit, :update, :destroy]

  def new
  end

  def edit
  end

  def increase
    # increase actual_question order
    @actual_question = ActualQuestion.find(params[:id])
    if @actual_question.qnorder == 1 || @actual_question.qnorder == @actual_question.goal.actual_questions.maximum(:qnorder)
      redirect_to goal_path(@actual_question.goal.id), notice: "Error: order is already at start or maximum."
      # notce: this won't work properly if there are different amounts of quetsions for checkins, reviews, etc.
      # ideally it should filter down to checkins / reviews
    else
      @actual_question.increase_order(@actual_question.goal)
      redirect_to goal_path(@actual_question.goal.id), notice: "Order successfully changed."
    end
    # end with a redirect
  end

  def decrease
    # decrease actual_question order
    @actual_question = ActualQuestion.find(params[:id])
    if @actual_question.qnorder == 1 || @actual_question.qnorder == @actual_question.goal.actual_questions.maximum(:qnorder)
      redirect_to goal_path(@actual_question.goal.id), notice: "Error: order is already at start or maximum."
      # notce: this won't work properly if there are different amounts of quetsions for checkins, reviews, etc.
      # ideally it should filter down to checkins / reviews
    else
      @actual_question.decrease_order(@actual_question.goal)
      redirect_to goal_path(@actual_question.goal.id), notice: "Order successfully changed."
    end
    # end with a redirect
  end


  # POST /actual_questions
  # POST /actual_questions.json
  def create
    @actual_question = ActualQuestion.new(actual_question_params)

    respond_to do |format|
      if @actual_question.save
        format.html { redirect_to actual_questions_url, notice: 'Question was successfully tied to Goal.' }
        format.json { render :index, status: :created, location: @actual_question }
      else
        format.html { render :new }
        format.json { render json: @actual_question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /actual_questions/1
  # PATCH/PUT /actual_questions/1.json
  def update
    respond_to do |format|
      if @actual_question.update(actual_question_params)
        format.html { redirect_to actual_questions_url, notice: 'actual_question was successfully updated.' }
        format.json { render :index, status: :ok, location: @actual_question }
      else
        format.html { render :edit }
        format.json { render json: @actual_question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /actual_questions/1
  # DELETE /actual_questions/1.json
  def destroy
    @actual_question.destroy
    respond_to do |format|
      format.html { redirect_to actual_questions_url, notice: 'actual_question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_actual_question
      @actual_question = ActualQuestion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def actual_question_params
      params.require(:actual_question).permit(:order, :goal_id, :question_id,
        rating_answers_attributes: [:id, :answer],
        comment_answers_attributes: [:id, :answer],
        boolean_answers_attributes: [:id, :answer])
    end
end
