json.array!(@boolean_answers) do |boolean_answer|
  json.extract! boolean_answer, :id, :answer, :goal_id, :question_id
  json.url boolean_answer_url(boolean_answer, format: :json)
end
