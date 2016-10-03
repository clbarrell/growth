class CheckinLog < ActiveRecord::Base
  belongs_to :goal

  # VALIDATIONS

  validates :goal, :checked_in_at, presence: true
end
