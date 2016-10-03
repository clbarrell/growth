module GoalsHelper

  def goal_type
    %w(Standard Contextual)
  end

  def freq_options
    %w(Daily Weekly Fortnightly Monthly Quarterly)
  end

  def agreement_options
    [["Strongly Agree", 5], ["Agree", 4], ["Neutral", 3], ["Disagree", 2], ["Strongly Disagree", 1]]
  end

  def boolean_options
    [["True", 'true'], ["False", 'false']]
  end

  def checkin_log_graph(goal)
    if goal.checkin_count > 1
      content_tag :div, class: "col-sm-12" do
        line_chart CheckinLog.where(goal: goal).group_by_day(:checked_in_at).count, height: "100px", id: "checkin_log_graph"
      end
    end
  end

  def timewordslastcheckin(goal)
    goal.checkin_count > 0 ? "#{distance_of_time_in_words_to_now(goal.checkin_logs.try(:last).try(:created_at))} ago" : "never"
  end

  def checkin_warning(goal)
    if goal.is_it_checkin_time?
      content_tag :span, class: "glyphicon glyphicon-flag text-primary", 'aria-hidden' => "true" do
      end
    end
  end

end
