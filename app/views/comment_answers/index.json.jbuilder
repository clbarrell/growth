json.array!(@comment_answers) do |comment_answer|
  json.extract! comment_answer, :id, :answer, :date, :question_id, :goal_id
  json.url comment_answer_url(comment_answer, format: :json)
end
