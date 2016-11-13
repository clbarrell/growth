module SocialGoalRecordsHelper

  def people_with_access(goal)
    people = SocialGoalRecord.where(goal: goal).pluck(:user_id).map { |u| User.select(:id, :name, :email).find(u) }
    people.empty? ? "none" : people.join(", ")
  end
end
