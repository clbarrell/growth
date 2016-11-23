class CreateSocialGoalRecords < ActiveRecord::Migration
  def change
    create_table :social_goal_records do |t|
      t.references :user, index: true, foreign_key: true
      t.references :goal, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
