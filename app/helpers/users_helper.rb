module UsersHelper

  def timewordslastcheckin(goal)
    goal.checkin_count > 0 ? "#{distance_of_time_in_words_to_now(goal.checkin_logs.try(:last).try(:created_at))} ago" : "never"
  end
end
