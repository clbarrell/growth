class CreateTemplateQuestions < ActiveRecord::Migration
  def change
    create_table :template_questions do |t|
      t.string :text
      t.string :qntype
      t.string :scale
      t.integer :default_order

      t.timestamps null: false
    end
  end
end
