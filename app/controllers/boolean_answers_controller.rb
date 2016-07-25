class BooleanAnswersController < ApplicationController
  before_action :set_boolean_answer, only: [:show, :edit, :update, :destroy]

  # GET /boolean_answers
  # GET /boolean_answers.json
  def index
    @boolean_answers = BooleanAnswer.all
  end

  # GET /boolean_answers/1
  # GET /boolean_answers/1.json
  def show
  end

  # GET /boolean_answers/new
  def new
    @boolean_answer = BooleanAnswer.new
  end

  # GET /boolean_answers/1/edit
  def edit
  end

  # POST /boolean_answers
  # POST /boolean_answers.json
  def create
    @boolean_answer = BooleanAnswer.new(boolean_answer_params)

    respond_to do |format|
      if @boolean_answer.save
        format.html { redirect_to @boolean_answer, notice: 'Boolean answer was successfully created.' }
        format.json { render :show, status: :created, location: @boolean_answer }
      else
        format.html { render :new }
        format.json { render json: @boolean_answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /boolean_answers/1
  # PATCH/PUT /boolean_answers/1.json
  def update
    respond_to do |format|
      if @boolean_answer.update(boolean_answer_params)
        format.html { redirect_to @boolean_answer, notice: 'Boolean answer was successfully updated.' }
        format.json { render :show, status: :ok, location: @boolean_answer }
      else
        format.html { render :edit }
        format.json { render json: @boolean_answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /boolean_answers/1
  # DELETE /boolean_answers/1.json
  def destroy
    @boolean_answer.destroy
    respond_to do |format|
      format.html { redirect_to boolean_answers_url, notice: 'Boolean answer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_boolean_answer
      @boolean_answer = BooleanAnswer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def boolean_answer_params
      params.require(:boolean_answer).permit(:answer, :actual_question_id)
    end
end
