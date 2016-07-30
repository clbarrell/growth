class BooleanAnswer < ActiveRecord::Base
  belongs_to :question
  validates :question, presence: true

  # -- MDOEL --
  # id: integer
  # answer: boolean
  # created_at: datetime
  # updated_at: datetime
  # question_id: integer
  # belongs_to :question

  scope :empty, -> { where(answer: nil) }
end
