class ActualQuestion < ActiveRecord::Base
  belongs_to :goal
  belongs_to :question

  has_many :rating_answers
  has_many :comment_answers
  has_many :boolean_answers
  
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

  def create_answer
    # Create corresponding answer model
    if question.scale == "Text"

    elsif question.scale == "Agreement"

    elsif question.scale == "True/False"

    end

  end

  # CLASS METHODS

  def self.answer
    # retrive appropriate type of answer model
    # text / agreement / True/False
    if self.question.scale == "Text"
      # do something

    elsif question.scale == "Agreement"
      # do something

    elsif question.scale == "True/False"
      # do something
    end



  end

end
