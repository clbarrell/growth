class ChangeColumnNames < ActiveRecord::Migration
  def change
    rename_column :questions, :type, :qntype
    rename_column :goals, :type, :goaltype
  end
end
