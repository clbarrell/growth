class AddIndexToQuestionsOnGoal < ActiveRecord::Migration
  def change
    add_index(:questions, :goal_id)
  end
end
