class AddSuccessFieldToGoal < ActiveRecord::Migration
  def change
    add_column :goals, :success_description, :text
  end
end
