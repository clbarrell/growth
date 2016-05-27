class Goal < ActiveRecord::Base
  has_many :rating_answers
  has_many :comment_answers
  belongs_to :user
  has_and_belongs_to_many :questions, -> { readonly }



  #* title / s
  #* description / text
  #* frequency / s
  #* goaltype / s (new: GoalType)
  #* user_ID

  # VALIDATIONS
  validates :title, :description, :user, :goaltype, presence: true
  validates :frequency, inclusion: { in: %w(Daily Weekly Fortnightly Monthly Quarterly),
    message: "%{value} is not a valid frequency" }
  # not validating goaltype yet

  # METHODS

  def update_last_checkin
    self.last_checkin = Time.now
  end

  def new_checkin
    self.checkin_count += 1
  end

end
