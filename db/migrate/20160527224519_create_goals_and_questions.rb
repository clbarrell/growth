class CreateGoalsAndQuestions < ActiveRecord::Migration
  def change
    create_table :goals_questions, id: false do |t|
      t.belongs_to :goal, index: true
      t.belongs_to :question, index: true
    end
  end
end
