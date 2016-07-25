class ActualQuestion < ActiveRecord::Base
  belongs_to :goal
  belongs_to :question

  has_many :rating_answers
  has_many :comment_answers
  has_many :boolean_answers

  accepts_nested_attributes_for :rating_answers, reject_if: :all_blank
  accepts_nested_attributes_for :comment_answers, reject_if: :all_blank
  accepts_nested_attributes_for :boolean_answers, reject_if: :all_blank

  # ~~ COLUMNS ~~
  # goal_id
  # question_id
  # qnorder

  # ~~ SCOPE ~~
  scope :checkins, -> { includes(:question).where(questions: { qntype: "Checkin"}).order(:qnorder)}
  scope :reviews, -> { includes(:question).where(questions: { qntype: "Review"}).order(:qnorder)}

  # how to rest the order ofi t allow
  # ActualQuestion.find_each { |qn| qn.update(qnorder: qn.question.default_order) }

  # INSTANCE METHODS

  def increase_order(goal)
    # increase order of AQ
    qen = ActualQuestion.where("goal_id = ? AND qnorder = ?", self.goal.id, self.qnorder - 1)
    qen.each do |qn|
      # make sure qen is of correct type
      if qn.question.qntype == self.question.qntype
        qn.update(qnorder: qn.qnorder + 1 )
      end
    end
    self.update(qnorder: self.qnorder - 1)
  end

  def decrease_order(goal)
    # increase order of AQ
    qen = ActualQuestion.where("goal_id = ? AND qnorder = ?", self.goal.id, self.qnorder + 1)
    qen.each do |qn|
      # make sure qen is of correct type
      if qn.question.qntype == self.question.qntype
        qn.update(qnorder: qn.qnorder - 1 )
      end
    end
    self.update(qnorder: self.qnorder + 1)
  end

  # CLASS METHODS
  # retrieve appropriate type of answer
  def answer
    # retrive appropriate type of answer model
    # text / agreement / True/False
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
