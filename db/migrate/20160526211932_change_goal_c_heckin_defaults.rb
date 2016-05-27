class ChangeGoalCHeckinDefaults < ActiveRecord::Migration
  def change
    change_column(:goals, :last_checkin, :date, default: Date.today)
    change_column(:goals, :checkin_count, :integer, default: 0)
  end
end
