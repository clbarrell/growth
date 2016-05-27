class ChangeGoalField < ActiveRecord::Migration
  def change
    change_column :goals, :last_checkin, :datetime, default: nil
  end
end
