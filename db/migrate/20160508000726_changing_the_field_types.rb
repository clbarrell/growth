class ChangingTheFieldTypes < ActiveRecord::Migration
  def change
    change_column :rating_answers, :date,  :date
    change_column :goals, :description, :text
  end
end
