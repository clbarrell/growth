module SocialGoalRecordsHelper

  def people_with_access(goal)
    people = User.joins(:social_goal_records).where(social_goal_records: { goal: goal })
    people.empty? ? "none" : people.join(", ")
  end
end
