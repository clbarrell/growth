json.array!(@goals) do |goal|
  json.extract! goal, :id, :title, :description, :frequency, :type, :user_id
  json.url goal_url(goal, format: :json)
end
