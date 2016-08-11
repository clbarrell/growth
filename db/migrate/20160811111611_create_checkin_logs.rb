class CreateCheckinLogs < ActiveRecord::Migration
  def change
    create_table :checkin_logs do |t|
      t.date :date
      t.references :goal, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
