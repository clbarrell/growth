class CreateBooleanAnswers < ActiveRecord::Migration
  def change
    create_table :boolean_answers do |t|
      t.boolean :answer
      t.references :goal, index: true, foreign_key: true
      t.references :question, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
