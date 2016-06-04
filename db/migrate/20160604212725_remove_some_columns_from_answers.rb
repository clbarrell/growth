class RemoveSomeColumnsFromAnswers < ActiveRecord::Migration
  def change
    remove_column :comment_answers, :goal_id, :integer
    remove_column :rating_answers, :goal_id, :integer
    remove_column :boolean_answers, :goal_id, :integer
  end
end
