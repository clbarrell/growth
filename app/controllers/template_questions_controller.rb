class TemplateQuestionsController < ApplicationController
  before_action :set_template_question, only: [:show, :edit, :update, :destroy]
  before_action :authorise_user
  before_action :authenticate_user!


  # GET /template_questions
  # GET /template_questions.json
  def index
    @template_questions = TemplateQuestion.all
    @checkin_questions = TemplateQuestion.checkin
    @review_questions = TemplateQuestion.review
  end

  # GET /template_questions/1
  # GET /template_questions/1.json
  def show
  end

  # GET /template_questions/new
  def new
    @template_question = TemplateQuestion.new
  end

  # GET /template_questions/1/edit
  def edit
  end

  # POST /template_questions
  # POST /template_questions.json
  def create
    @template_question = TemplateQuestion.new(template_question_params)
    @template_question.set_default_order

    respond_to do |format|
      if @template_question.save
        format.html { redirect_to @template_question, notice: 'Template question was successfully created.' }
        format.json { render :show, status: :created, location: @template_question }
      else
        format.html { render :new }
        format.json { render json: @template_question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /template_questions/1
  # PATCH/PUT /template_questions/1.json
  def update
    respond_to do |format|
      if @template_question.update(template_question_params)
        format.html { redirect_to @template_question, notice: 'Template question was successfully updated.' }
        format.json { render :show, status: :ok, location: @template_question }
      else
        format.html { render :edit }
        format.json { render json: @template_question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /template_questions/1
  # DELETE /template_questions/1.json
  def destroy
    @template_question.destroy
    respond_to do |format|
      format.html { redirect_to template_questions_url, notice: 'Template question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_template_question
      @template_question = TemplateQuestion.find(params[:id])
    end

    def authorise_user
      if current_user.email != "clbarrell@gmail.com"
        redirect_to goals_path, alert: "You don't have access to the templated questions."
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def template_question_params
      params.require(:template_question).permit(:text, :qntype, :scale)
    end
end
