class AddCheckedInAtToCheckinLogs < ActiveRecord::Migration
  def change
    add_column :checkin_logs, :checked_in_at, :datetime, index: true
    add_column :goals, :last_checkin, :datetime
  end
end
