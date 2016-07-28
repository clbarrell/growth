class Goal < ActiveRecord::Base
  belongs_to :user
  has_many :questions
  has_many :rating_answers, :through => :questions
  has_many :comment_answers, :through => :questions
  has_many :boolean_answers, :through => :questions

  accepts_nested_attributes_for :rating_answers, reject_if: :all_blank
  accepts_nested_attributes_for :comment_answers, reject_if: :all_blank
  accepts_nested_attributes_for :boolean_answers, reject_if: :all_blank

  # SCOPES ~~~~
  scope :checkin_questions, -> { includes(:questions).where(questions: { qntype: "Checkin"}).order(:qnorder)}
  scope :review_questions, -> { includes(:questions).where(questions: { qntype: "Review"}).order(:qnorder)}
  # will this work?? test it!


  #scope :reviews, -> { where(questions.qntype: 'Review').order(:qnorder) }

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

  after_create :create_default_questions

  # METHODS
  def create_default_questions
    # set the default list of questions
    TemplateQuestions.find_each do |q|
      Question.new(goal_id: self.id, question: q.text,
                        qntype: q.qntype, scale: q.scale, default_order: q.default_order)
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

end
