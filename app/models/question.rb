class Question < ActiveRecord::Base

  has_many :goals, :through => :actual_question
  has_many :actual_questions

  validates :question, :qntype, :scale, presence: true

  # -- FIELDS --
  # question - text of question
  # qntype - checkin / review
  # scale - text / agreement / True/False
  # default_order

  def set_default_order
    self.default_order = Question.maximum("default_order") + 1
  end

  def self.checkin
    where(qntype: 'Checkin').order(:default_order)
  end

  def self.review
    where(qntype: 'Review').order(:default_order)
  end

end
