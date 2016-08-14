class User < ActiveRecord::Base
  has_many :goals

  def to_s
    self.name
  end


  # TURN THIS INTO A COLUMN variable
  # takes too much data loading
  def checkin_ready_goals
    count = 0
    goals.each do |x|
      count += 1 if x.is_it_checkin_time?
    end
    count
  end


end
