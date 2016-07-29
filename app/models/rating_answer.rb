class RatingAnswer < ActiveRecord::Base
  belongs_to :question

  validates :question, presence: true



  scope :empty, -> { where(answer: nil) }

end
