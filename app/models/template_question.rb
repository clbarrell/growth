class TemplateQuestion < ActiveRecord::Base
  # Class for the hardcoded template questions

  validates :text, :qntype, :scale, presence: true
  validates :qntype, inclusion: { in: %w(Checkin Review) }
  validates :scale, inclusion: { in: %w(Agreement Comment True/False) }

  # FIELDS
  # TemplateQuestion
  #   id: integer
  #   text: string
  #   qntype: string
  #   scale: string
  #   default_order: integer
  #   created_at: datetime
  #   updated_at: datetime

  def set_default_order
    self.default_order = TemplateQuestion.where(qntype: qntype).maximum("default_order") + 1
  end

  def self.checkin
    where(qntype: 'Checkin').order(:default_order)
  end

  def self.review
    where(qntype: 'Review').order(:default_order)
  end

end
