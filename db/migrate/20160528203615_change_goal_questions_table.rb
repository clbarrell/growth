class ChangeGoalQuestionsTable < ActiveRecord::Migration
  def change
    add_column :goals_questions, :qnorder, :integer
    add_column :goals_questions, :id, :primary_key
    rename_table :goals_questions, :actual_questions
  end
end
