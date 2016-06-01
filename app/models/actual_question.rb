class ActualQuestion < ActiveRecord::Base
  belongs_to :goal
  belongs_to :question

  # ~~ COLUMNS ~~
  # goal_id
  # question_id
  # qnorder

  # ~~ SCOPE ~~
  scope :checkins, -> { includes(:question).where(questions: { qntype: "Checkin"}).order(:qnorder)}
  scope :reviews, -> { includes(:question).where(questions: { qntype: "Review"}).order(:qnorder)}

  # how to rest the order ofi t allow
  # ActualQuestion.find_each { |qn| qn.update(qnorder: qn.question.default_order) }

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

end
