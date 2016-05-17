json.array!(@rating_answers) do |rating_answer|
  json.extract! rating_answer, :id, :answer, :date, :question_id, :goal_id
  json.url rating_answer_url(rating_answer, format: :json)
end
