class Question < ActiveRecord::Base

    belongs_to :goal
    has_many :rating_answers, dependent: :destroy
    has_many :comment_answers, dependent: :destroy
    has_many :boolean_answers, dependent: :destroy

    accepts_nested_attributes_for :rating_answers, reject_if: proc { |attributes| attributes['answer'].blank? }
    accepts_nested_attributes_for :comment_answers, reject_if: proc { |attributes| attributes['answer'].blank? }
    accepts_nested_attributes_for :boolean_answers, reject_if: proc { |attributes| attributes['answer'].blank? }

    validates :question, presence: true
    validates :qntype, inclusion: { in: %w(Checkin Review) }
    validates :scale, inclusion: { in: %w(Agreement Comment True/False) }

    # -- MODEL --
    # id: integer
    # question: string
    # qntype: string
    # created_at: datetime
    # updated_at: datetime
    # scale: text
    # qnorder: integer
    # goal_id: integer
    # belongs_to :goal
    # has_many :boolean_answers
    # has_many :comment_answers
    # has_many :rating_answers

    # ~~ SCOPE ~~
    scope :checkins, -> { where(qntype: 'Checkin').order(:qnorder) }
    scope :reviews, -> { where(qntype: 'Review').order(:qnorder) }

    # INSTANCE METHODS
    def increase_order()
      # increase order of AQ
      qen = Question.where("goal_id = ? AND qnorder = ?", self.goal.id, self.qnorder - 1)
      qen.each do |qn|
        # make sure qen is of correct type
        if qn.qntype == self.qntype
          qn.update(qnorder: qn.qnorder + 1 )
        end
      end
      self.update(qnorder: self.qnorder - 1)
    end

    def decrease_order()
      # increase order of AQ
      qen = Question.where("goal_id = ? AND qnorder = ?", self.goal.id, self.qnorder + 1)
      qen.each do |qn|
        # make sure qen is of correct type
        if qn.qntype == self.qntype
          qn.update(qnorder: qn.qnorder - 1 )
        end
      end
      self.update(qnorder: self.qnorder + 1)
    end

    def set_default_order
      self.qnorder = self.goal.questions.where(qntype: qntype).maximum("qnorder") + 1
    end

    def to_s
      question
    end

    def answer_data_for_graph
      # to get into proper array
      if scale == "Agreement"
        # RATING ANSWERSS
        rating_answers.map { |x| [Time.zone.at(x.created_at).to_date, x.answer] }
      elsif scale == "True/False"
        # BOOLEAN
        boolean_answers.map { |x| [Time.zone.at(x.created_at).to_date, x.to_numbers] }
      end
    end

end
