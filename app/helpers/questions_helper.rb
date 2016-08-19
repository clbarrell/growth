module QuestionsHelper

  def scale_options
    %w(Agreement Comment True/False)
  end

  def graph_question(question)
    if question.scale == "Agreement"
      line_chart question.answer_data_for_graph, min: 1, max: 5, height: "150px"
    else
      line_chart question.answer_data_for_graph, height: "150px"
    end
  end

  





end
