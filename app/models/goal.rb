class Goal < ActiveRecord::Base
  has_many :rating_answers
  has_many :comment_answers
  belongs_to :user
  has_many :questions, :through => :actual_questions
  has_many :actual_questions

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
  # not validating goaltype yet

  after_create :assign_questions

  # METHODS

  def update_last_checkin
    self.last_checkin = Time.now
  end

  def new_checkin
    self.checkin_count += 1
  end


  def assign_questions
    # method to assign all questions to goal
    Question.find_each do |qn|
      ActualQuestion.create(goal_id: self.id, question_id: qn.id, qnorder: qn.default_order)
    end

  end


end
