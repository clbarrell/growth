class SocialGoalRecord < ActiveRecord::Base
  belongs_to :user
  belongs_to :goal
  belongs_to :goal_owner, class_name: "User",
                        foreign_key: "goal_owner_id"


  validates_uniqueness_of :user_id, :scope => :goal_id
  validates_presence_of :user, :goal, :goal_owner
  validate :goal_owner_cannot_be_user

  def self.users_with_access(goal)
    # get list of users with access
    where(goal: goal).pluck(:user_id)
  end

  def title
    goal.title
  end

  def goal_owner_cannot_be_user
    if user == goal_owner
      errors.add(:user, "can't be the same as the owner of the goal")
    end
  end

end
