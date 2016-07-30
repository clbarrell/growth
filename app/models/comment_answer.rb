class CommentAnswer < ActiveRecord::Base
  belongs_to :question

  validates :question, presence: true

  # -- MDOEL --
  # id: integer
  # answer: text
  # created_at: datetime
  # updated_at: datetime
  # question_id: integer
  # belongs_to :question

 scope :empty, -> { where(answer: nil) }

end
