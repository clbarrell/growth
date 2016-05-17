class CreateRatingAnswers < ActiveRecord::Migration
  def change
    create_table :rating_answers do |t|
      t.integer :answer
      t.datetime :date
      t.references :question, index: true, foreign_key: true
      t.references :goal, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
