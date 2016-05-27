class NewGoalColumn < ActiveRecord::Migration
  def change
    add_column :goals, :last_checkin, :date
    add_column :goals, :checkin_count, :integer
  end
end
