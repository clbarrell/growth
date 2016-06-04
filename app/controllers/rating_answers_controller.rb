class RatingAnswersController < ApplicationController
  before_action :set_rating_answer, only: [:show, :edit, :update, :destroy]

  # GET /rating_answers
  # GET /rating_answers.json
  def index
    @rating_answers = RatingAnswer.all
  end

  # GET /rating_answers/1
  # GET /rating_answers/1.json
  def show
  end

  # GET /rating_answers/new
  def new
    @rating_answer = RatingAnswer.new
  end

  # GET /rating_answers/1/edit
  def edit
  end

  # POST /rating_answers
  # POST /rating_answers.json
  def create
    @rating_answer = RatingAnswer.new(rating_answer_params)

    respond_to do |format|
      if @rating_answer.save
        format.html { redirect_to @rating_answer, notice: 'Rating answer was successfully created.' }
        format.json { render :show, status: :created, location: @rating_answer }
      else
        format.html { render :new }
        format.json { render json: @rating_answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rating_answers/1
  # PATCH/PUT /rating_answers/1.json
  def update
    respond_to do |format|
      if @rating_answer.update(rating_answer_params)
        format.html { redirect_to @rating_answer, notice: 'Rating answer was successfully updated.' }
        format.json { render :show, status: :ok, location: @rating_answer }
      else
        format.html { render :edit }
        format.json { render json: @rating_answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rating_answers/1
  # DELETE /rating_answers/1.json
  def destroy
    @rating_answer.destroy
    respond_to do |format|
      format.html { redirect_to rating_answers_url, notice: 'Rating answer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rating_answer
      @rating_answer = RatingAnswer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rating_answer_params
      params.require(:rating_answer).permit(:answer, :actual_question_id)
    end
end
