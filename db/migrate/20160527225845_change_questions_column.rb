class ChangeQuestionsColumn < ActiveRecord::Migration
  def change
    add_column :questions, :scale, :text
  end
end
