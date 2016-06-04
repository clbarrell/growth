class Goal < ActiveRecord::Base
  belongs_to :user
  has_many :questions, :through => :actual_questions
  has_many :actual_questions
  has_many :rating_answers, :through => :actual_questions
  has_many :comment_answers, :through => :actual_questions
  has_many :boolean_answers, :through => :actual_questions

  # SCOPES ~~~~
  # scope :checkin_questions, -> { includes(:questions).where(questions: { qntype: "Checkin"})}
  #* title / s
  #* description / text
  #* frequency / s
  #* goaltype / s (new: GoalType)
  #* user_ID

  # VALIDATIONS
  validates :title, :description, :user, :goaltype, presence: true
  validates :frequency, inclusion: { in: %w(Daily Weekly Fortnightly Monthly Quarterly),
    message: "%{value} is not a valid frequency" }
  validates :goaltype, inclusion: { in: %w(Standard Contextual)}
  # not validating goaltype yet

  after_create :assign_questions

  # METHODS

  def new_checkin
    self.update(checkin_count: checkin_count + 1, last_checkin: Time.now)
  end

  def is_it_checkin_time?
    # true if enough time has elapsed since last checkin
    # calculate time since according to frequency
    if frequency == "Daily"
      (Time.now.to_date - last_checkin.to_date) > 1 ? true : false
    elsif frequency == "Weekly"
      (Time.now.to_date - last_checkin.to_date) > 7 ? true : false
    elsif frequency == "Fortnightly"
      (Time.now.to_date - ast_checkin.to_date) > 14 ? true : false
    elsif frequency == "Monthly"
      (Time.now.to_date - last_checkin.to_date) > 30 ? true : false
    elsif frequency == "Quarterly"
      (Time.now.to_date - last_checkin.to_date) > 90 ? true : false
    elsif frequency.nil?
      true
    end
  end

  def assign_questions
    # method to assign all questions to goal
    Question.find_each do |qn|
      ActualQuestion.create(goal_id: self.id, question_id: qn.id, qnorder: qn.default_order)
    end

  end


end
