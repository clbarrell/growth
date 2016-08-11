class RemoveColumnsCheckinFromGoals < ActiveRecord::Migration
  def change
    remove_column :goals, :checkin_count, :integer
    remove_column :goals, :last_checkin, :datetime
  end
end
