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
    %w(True False)
  end

  # CHECKIN HELPERS
  def form_field_for(actual_q, aq_form)
    # return correct field ERB
    capture do
      if actual_q.question.scale == "Text"
        concat aq_form.text_field(:answer, class: "form-control")
      elsif actual_q.question.scale == "Agreement"
        concat aq_form.select(:answer, agreement_options, { prompt: true }, { class: "form-control" })
      elsif actual_q.question.scale == "True/False"
        concat aq_form.select(:answer, boolean_options, { prompt: true }, { class: "form-control" })
      end
    end
  end

  def form_field_forv2(actual_q, aq_form)
    # return correct field ERB
    capture do
      if actual_q.question.scale == "Text"
        concat aq_form.text_field(:answer, class: "form-control")
      elsif actual_q.question.scale == "Agreement"
        concat aq_form.select(:answer, agreement_options, { prompt: true }, { class: "form-control" })
      elsif actual_q.question.scale == "True/False"
        concat aq_form.select(:answer, boolean_options, { prompt: true }, { class: "form-control" })
      end
    end
  end


end
