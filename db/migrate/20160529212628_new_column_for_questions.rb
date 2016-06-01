class NewColumnForQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :default_order, :integer
  end
end
