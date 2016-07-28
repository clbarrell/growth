class Question < ActiveRecord::Base

    belongs_to :goal
    has_many :rating_answers
    has_many :comment_answers
    has_many :boolean_answers


    validates :question, :qntype, :scale, presence: true

    # -- FIELDS --
    # question - text of question
    # qntype - checkin / review
    # scale - text / agreement / True/False
    # default_order

    # ~~ SCOPE ~~
    scope :checkins, -> { where(qntype: 'Checkin').order(:qnorder) }
    scope :reviews, -> { where(qntype: 'Review').order(:qnorder) }

    def self.checkin
        where(qntype: 'Checkin').order(:default_order)
    end

    def self.review
        where(qntype: 'Review').order(:default_order)
    end

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

    def answer
      # retrive appropriate type of answer model
      # text / agreement / True/False
      # WILL RETIRE THIS AND USE BUILD INSTEAD!
      if question.scale == "Text"
        # do something
        if comment_answers.empty.any?
          comment_answers.empty.take
        else
          CommentAnswer.create(actual_question_id: self.id)
          comment_answers.empty.take
        end
      elsif question.scale == "Agreement"
        # do something
        if rating_answers.empty.any?
          rating_answers.empty.take
        else
          RatingAnswer.create(actual_question_id: self.id)
          rating_answers.empty.take
        end
      elsif question.scale == "True/False"
        # do something
        if boolean_answers.empty.any?
          boolean_answers.empty.take
        else
          BooleanAnswer.create(actual_question_id: self.id)
          boolean_answers.empty.take
        end
      end
    end

end
