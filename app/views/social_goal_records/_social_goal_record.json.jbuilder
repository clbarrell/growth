json.extract! social_goal_record, :id, :user_id, :goal_id, :created_at, :updated_at
json.url social_goal_record_url(social_goal_record, format: :json)