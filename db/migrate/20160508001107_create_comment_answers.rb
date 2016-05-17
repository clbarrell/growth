class CreateCommentAnswers < ActiveRecord::Migration
  def change
    create_table :comment_answers do |t|
      t.text :answer
      t.date :date
      t.references :question, index: true, foreign_key: true
      t.references :goal, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
