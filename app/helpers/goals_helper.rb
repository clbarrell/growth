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

end
