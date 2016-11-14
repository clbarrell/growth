class AddGoalOwnerToSocialGoalRecord < ActiveRecord::Migration
  def change
    add_column :social_goal_records, :goal_owner_id, :integer
  end
end
