class GoalsController < ApplicationController
  before_action :set_goal, only: [:show, :edit, :update, :destroy, :update_checkin, :undo_checkin, :reset, :social]
  before_action :authenticate_user!
  before_action :authorise_user, only: [:show, :checkin, :edit, :update, :destroy, :update_checkin, :undo_checkin, :reset]
  before_action :authorise_user_answer_view, only: :checkin_answers

  # GET /goals
  # GET /goals.json
  def index
    @user = current_user
    @goals = @user.goals.order(last_checkin: :asc)
    @social_goals = @user.social_goals
    @goal_owners = @user.goal_owners
  end

  # GET /goals/1
  # GET /goals/1.json
  def show
    @goal = Goal.find(params[:id])
    @checkin_questions = @goal.checkin_questions
    @review_questions = @goal.review_questions
    # get checkin logs
    # return max of 28 days ago
    # only good
    time = 27.days.ago
    time = @goal.created_at if @goal.created_at > 27.days.ago
    @checkin_dates = @goal.checkin_logs.where("checked_in_at > ?", time).pluck(:checked_in_at).map{ |date| date.to_date }
    @date_array = (time.to_date..Time.zone.today).to_a #can iterate on this
    # (28.days.ago.to_date..Time.zone.today).map{ |date| date.strftime("%b %d") }
    @date_hash = Hash.new
    @date_array.each do |date|
      if @checkin_dates.include?(date)
        @date_hash[date] = true
      else
        @date_hash[date] = false
      end
    end
    # end up with a hash?
    # date_hash[20 Oct 2016] => false
  end

  # GET /goals/new
  def new
    @goal = Goal.new
  end

  def social
    # to edit and change SGRs
    @user_to_find = User.new
    @sgr = SocialGoalRecord.new
  end

  def search_for_email
    # does email match an excisting user
    goal = Goal.find(params[:goal_id])
    user = params["user"]
    valid_email?(user[:email]).present? ? @email_valid=true : @email_valid=false
    unless @email_valid == false
      @user_found = User.exists?(email: user[:email])
      respond_to do |format|
        if @user_found == true
          # format.html { redirect_to @social_goal_record, notice: 'Social goal record was successfully created.' }
          @target_user = User.find_by(email: user[:email])
          # format.json { render json: @target_user, status: :created }
          # Does the user already have access?
          if @target_user.social_goals.include?(goal) || @target_user == current_user
            @already_has_access = true
          end
          format.js   { }
        else
          @target_user = User.new(email: user[:email])
            # format.html { render :new }
          # format.json { render json: @social_goal_record.errors, status: :unprocessable_entity }
          format.js   { }
        end
      end
    end

  end

  # goals/1/checkin
  def checkin
    # view for checkin
    @goal = Goal.find(params[:id])
    @questions = @goal.checkin_questions
  end

  # goals/1/checkin_answers
  def checkin_answers
    # view for looking at checkin answers
    @goal = Goal.find(params[:id])
    @questions = @goal.checkin_questions
  end

  def reset
    # to reset all the goal's questions
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
    # checkin_date" => "two days ago" / "yesterday" / "today" (or nothing)
    respond_to do |format|
      if @goal.update(goal_params)
        if params[:checkin_date] == "yesterday"
          # change to yesterday
          logger.info "checking into yesterday"
          @goal.new_checkin(Time.zone.now - 1.day)
          @goal.old_checkin_change("yesterday")
        elsif params[:checkin_date] == "two days ago"
          # change to 2 days ago
          @goal.new_checkin(Time.zone.now - 2.days)
          @goal.old_checkin_change("two days ago")
          logger.info "checking into two days ago"
        else
          @goal.new_checkin
        end

        format.html { redirect_to checkin_answers_goal_path(params[:id]) }
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
    @goal.user = current_user
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
    # ensure you don't look at other's goals
    def authorise_user
      if Goal.find(params[:id]).user != current_user
        redirect_to goals_path, alert: "You don't have access to this goal."
      end
    end

    def authorise_user_answer_view
      if Goal.find(params[:id]).user != current_user
        if not SocialGoalRecord.users_with_access(params[:id]).include?(current_user.id)
          redirect_to goals_path, alert: "You don't have access to this goal."
        end
      end
    end

    def set_goal
      @goal = Goal.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def goal_params
      params.require(:goal).permit(:title, :description, :frequency, :success_description,
      :goaltype, :user_id,
        questions_attributes: [:id, :question,
            rating_answers_attributes: [:id, :answer, :question_id],
            comment_answers_attributes: [:id, :answer, :question_id],
            boolean_answers_attributes: [:id, :answer, :question_id]
        ])
    end
end
