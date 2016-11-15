module SocialGoalRecordsHelper

  def list_people_with_access(goal)
    content_tag :ul do
      User.joins(:social_goal_records).where(social_goal_records: { goal: goal }).collect do |user|
        content_tag(:li, user.to_s)
      end.join.html_safe
    end
  end

  def disabled_link(goal)
    if SocialGoalRecord.users_with_access(goal).empty?
      "disabled"
    end
  end

end
