class ChangeColumnsOnActualQuestions < ActiveRecord::Migration
  def change
    remove_column :comment_answers, :question_id, :integer
    remove_column :rating_answers, :question_id, :integer
    remove_column :boolean_answers, :question_id, :integer
    remove_column :comment_answers, :date, :date
    remove_column :rating_answers, :date, :date
    add_reference :comment_answers, :actual_question, index: true
    add_reference :rating_answers, :actual_question, index: true
    add_reference :boolean_answers, :actual_question, index: true
  end
end
