class CheckinLog < ActiveRecord::Base
  belongs_to :goal

  # VALIDATIONS

  validates :goal, :date, presence: true

  
end
