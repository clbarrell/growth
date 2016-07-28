class UpdateDatabaseSchema < ActiveRecord::Migration
  def change
    # all the answers
    rename_column(:boolean_answers, :actual_question_id, :question_id)
    rename_column(:rating_answers, :actual_question_id, :question_id)
    rename_column(:comment_answers, :actual_question_id, :question_id)
    # question table
    add_reference(:questions, :goal)
  end
end
