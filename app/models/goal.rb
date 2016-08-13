class Goal < ActiveRecord::Base
    belongs_to :user
    has_many :questions
    has_many :checkin_logs

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
    #scope :checkin_questions, -> { includes(:questions).where(questions: { qntype: 'Checkin' }).order(:qnorder) }
    #scope :review_questions, -> { includes(:questions).where(questions: { qntype: 'Review' }).order(:qnorder) }
    # will this work?? test it!
    # scope :reviews, -> { where(questions.qntype: 'Review').order(:qnorder)
    # scope :checkin_questions, -> { includes(:questions).where(questions: { qntype: "Checkin"})}


    # VALIDATIONS
    validates :title, :description, :user, :goaltype, presence: true
    validates :frequency, inclusion: { in: %w(Daily Weekly Fortnightly Monthly Quarterly),
                                       message: '%{value} is not a valid frequency' }
    validates :goaltype, inclusion: { in: %w(Standard Contextual) }
    # not validating goaltype yet

    after_create :create_default_questions

    def checkin_questions
      questions.where(qntype: "Checkin").order(:qnorder)
    end

    def review_questions
      questions.where(qntype: "Review").order(:qnorder)
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

    def new_checkin
      checkin_logs.create(date: Date.today)
    end

    def last_checkin
      checkin_logs.try(:last).try(:date)
    end

    def undo_checkin
      checkin_logs.try(:last).try(:destroy)
    end

    def is_it_checkin_time?
        # true if enough time has elapsed since last checkin
        # calculate time since according to frequency
        if frequency.nil? || last_checkin.nil?
          true
        elsif frequency == 'Daily'
            (Date.today - last_checkin) > 0 ? true : false
        elsif frequency == 'Weekly'
            (Date.today - last_checkin) > 6 ? true : false
        elsif frequency == 'Fortnightly'
            (Date.today - last_checkin) > 13 ? true : false
        elsif frequency == 'Monthly'
            (Date.today - last_checkin) > 29 ? true : false
        elsif frequency == 'Quarterly'
            (Date.today - last_checkin) > 89 ? true : false
        end
    end

    def to_s
      title
    end
end
