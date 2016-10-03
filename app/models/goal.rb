class Goal < ActiveRecord::Base
  belongs_to :user
  has_many :questions, dependent: :destroy
  has_many :checkin_logs, dependent: :destroy

  has_many :rating_answers, through: :questions
  has_many :comment_answers, through: :questions
  has_many :boolean_answers, through: :questions

  accepts_nested_attributes_for :questions

  # MODEL
  # id: integer
  # title: string
  # description: text
  # frequency: string
  # goaltype: string
  # user_id: integer
  # created_at: datetime
  # updated_at: datetime
  # success_description: text
  # belongs_to :user
  # has_many :boolean_answers (through :questions)
  # has_many :comment_answers (through :questions)
  # has_many :questions
  # has_many :rating_answers (through :questions)

  # SCOPES ~~~~
  # scope :checkin_questions, -> { includes(:questions).where(questions: { qntype: 'Checkin' }).order(:qnorder) }
  # scope :review_questions, -> { includes(:questions).where(questions: { qntype: 'Review' }).order(:qnorder) }
  # will this work?? test it!
  # scope :reviews, -> { where(questions.qntype: 'Review').order(:qnorder)
  # scope :checkin_questions, -> { includes(:questions).where(questions: { qntype: "Checkin"})}

  # VALIDATIONS
  validates :title, :description, :user, presence: true
  validates :frequency, inclusion: { in: %w(Daily Weekly Fortnightly Monthly Quarterly),
                                     message: "You haven't picked a valid frequency" }
  # validates :goaltype, inclusion: { in: %w(Standard Contextual),
  #                                  message: "You haven't picked a valid Goal Type"}
  # not validating goaltype yet

  after_create :create_default_questions

  def checkin_questions
      questions.where(qntype: 'Checkin').order(:qnorder)
  end

  def review_questions
      questions.where(qntype: 'Review').order(:qnorder)
  end

  # METHODS
  def create_default_questions
      # set the default list of questions
      TemplateQuestion.find_each do |q|
          Question.create(goal_id: id, question: q.text,
                          qntype: q.qntype, scale: q.scale, qnorder: q.default_order)
      end
  end

  def checkin_count
      checkin_logs.count
  end

  def new_checkin(time = Time.zone.now)
      checkin_logs.create(checked_in_at: time)
      self.update(last_checkin: time)
  end

  def undo_checkin
      last_log = checkin_logs.try(:last) #.try(:destroy)
      time_range = (last_log.created_at - 1.hour)..(last_log.created_at + 1.hour)
      last_log.try(:destory)
      self.comment_answers.where(:created_at => time_range).find_each { |x| x.try(:destroy) }
      self.rating_answers.where(:created_at => time_range).find_each { |x| x.try(:destroy) }
      self.boolean_answers.where(:created_at => time_range).find_each { |x| x.try(:destroy) }
  end

  # redo the question orders when one is deleted
  def reset_question_orders(qntype = 'Checkin')
      questions = if qntype == 'Checkin'
                      checkin_questions
                  else
                      review_questions
                  end
      questions.order(:qnorder).each_with_index do |qn, index|
          qn.update(qnorder: index + 1)
      end
  end

  # updates created_at date for answers
  # to allow for historical checkins
  def old_checkin_change(date = "yesterday")
    if date == "yesterday"
      timeframe = Time.current - 1.day
    else
      timeframe = Time.current - 2.days
    end
    time_range = (Time.current - 2.hours)..Time.current
    # get all answers together
    ratings = rating_answers.where(:created_at => time_range)
    comments = comment_answers.where(:created_at => time_range)
    booleans = boolean_answers.where(:created_at => time_range)
    # ANSWERS.each { |x| x.update(created_at: 1.day.ago) }
    ratings.each { |x| x.update(created_at: timeframe) }
    comments.each { |x| x.update(created_at: timeframe) }
    booleans.each { |x| x.update(created_at: timeframe) }
  end


  def is_it_checkin_time?
      # true if enough time has elapsed since last checkin
      # calculate time since according to frequency
      if frequency.nil? || last_checkin.nil?
          true
      elsif frequency == 'Daily'
          (Time.zone.now - last_checkin) > 0 ? true : false
      elsif frequency == 'Weekly'
          (Time.zone.now - last_checkin) > 6 ? true : false
      elsif frequency == 'Fortnightly'
          (Time.zone.now - last_checkin) > 13 ? true : false
      elsif frequency == 'Monthly'
          (Time.zone.now - last_checkin) > 29 ? true : false
      elsif frequency == 'Quarterly'
          (Time.zone.now - last_checkin) > 89 ? true : false
      end
  end

  def to_s
      title
  end
end
