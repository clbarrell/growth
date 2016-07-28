class DropActualQuestionsTable < ActiveRecord::Migration
  def change
    drop_table(:actual_questions)
  end
end
