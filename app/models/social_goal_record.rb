class SocialGoalRecord < ActiveRecord::Base
  belongs_to :user
  belongs_to :goal

  validates_uniqueness_of :user_id, :scope => :goal_id

  def self.users_with_access(goal)
    # get list of users with access
    where(goal: goal).pluck(:user_id)
  end

end
