class User < ActiveRecord::Base
  has_many :goals

  def to_s
    self.name
  end

  def checkin_ready_goals
    goals.where(is_it_checkin_time?: true).count
  end


end
