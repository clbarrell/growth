module UsersHelper

  def timewordslastcheckin(goal)
    goal.checkin_count > 0 ? "#{distance_of_time_in_words_to_now(goal.last_checkin)} ago" : "never:"
  end
end
