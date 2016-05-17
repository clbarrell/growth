class Goal < ActiveRecord::Base
  has_many :rating_answers
  has_many :comment_answers
  belongs_to :user

  #* title / s
  #* description / text
  #* frequency / s
  #* goaltype / s (new: GoalType)
  #* user_ID

  # VALIDATIONS
  validates :title, :description, :user, :goaltype, presence: true
  validates :frequency, inclusion: { in: %w(daily weekly fortnightly monthly quarterly),
    message: "%{value} is not a valid frequency" }
  # not validating goaltype yet




end
