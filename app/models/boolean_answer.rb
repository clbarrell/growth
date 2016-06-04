class BooleanAnswer < ActiveRecord::Base
  belongs_to :actual_question

#  create_table "boolean_answers", force: :cascade do |t|
#    t.boolean  "answer"
#    t.integer  "goal_id"
#    t.integer  "actual_question_id"
#    t.datetime "created_at",  null: false
#    t.datetime "updated_at",  null: false
#  end


end
