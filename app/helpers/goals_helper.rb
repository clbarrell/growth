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
        line_chart CheckinLog.where(goal: goal).group_by_day(:date).count, height: "100px", id: "checkin_log_graph"
      end
    end
  end
end
