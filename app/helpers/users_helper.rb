module UsersHelper

  def timewordslastcheckin(goal)
    if goal.last_checkin.present?
      "#{distance_of_time_in_words_to_now(goal.last_checkin)} ago"
    else
      "never"
    end
  end
end
