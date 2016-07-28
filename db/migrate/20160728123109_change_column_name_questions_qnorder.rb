class ChangeColumnNameQuestionsQnorder < ActiveRecord::Migration
  def change
    rename_column(:questions, :default_order, :qnorder)
  end
end
