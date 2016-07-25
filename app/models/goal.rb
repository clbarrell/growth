class Goal < ActiveRecord::Base
  belongs_to :user

  has_many :actual_questions
  has_many :questions, :through => :actual_questions
  has_many :rating_answers, :through => :actual_questions
  has_many :comment_answers, :through => :actual_questions
  has_many :boolean_answers, :through => :actual_questions

  accepts_nested_attributes_for :rating_answers, reject_if: :all_blank
  accepts_nested_attributes_for :comment_answers, reject_if: :all_blank
  accepts_nested_attributes_for :boolean_answers, reject_if: :all_blank

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
  def create_default_questions
    # set the default list of questions
    # hard coded questions - will make own thing later

    # DOESN'T WORK BECAUSE OF THE WHOLE actual_questions THING!!!!!
    questions = [
      {question: "I paid sufficient attention to this goal", qntype: "Checkin", scale: "Agreement", default_order: 4},
      {question: "I made acceptable progress on this goal", qntype: "Checkin", scale: "Agreement", default_order: 1},
      {question: "I focussed on this goal", qntype: "Checkin", scale: "Agreement", default_order: 2},
      {question: "Describe your progress", qntype: "Checkin", scale: "Text", default_order: 6},
      {question: "Describe your progress over this period", qntype: "Review", scale: "Text", default_order: 4},
      {question: "I prioritised this goal enough", qntype: "Checkin", scale: "Agreement", default_order: 3},
      {question: "I've made this goal enough of a priority", qntype: "Review", scale: "Agreement", default_order: 3},
      {question: "Are you closer to your next milestone?", qntype: "Checkin", scale: "True/False", default_order: 5},
      {question: "I've progressed on this goal", qntype: "Review", scale: "True/False", default_order: 1},
      {question: "I am satisfied with this progress", qntype: "Review", scale: "Agreement", default_order: 2},
      {question: "How much closer are you to your next milestone? What's required to get you there?", qntype: "Review", scale: "Text", default_order: 5},
      {question: "How will you rectify this next %frequency%?", qntype: "Review", scale: "Text", default_order: 6}
    ]

    questions.each do |q|
      qn = Question.new(goal_id: self.id, question: q[:question],
                        qntype: q[:qntype], scale: q[:scale], default_order: q[:default_order])
    end
  end


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
