class CommentAnswer < ActiveRecord::Base
  belongs_to :actual_question
  belongs_to :goal

#  create_table "comment_answers", force: :cascade do |t|
#    t.text     "answer"
#    t.date     "date"
#    t.integer  "question_id"
#    t.integer  "goal_id"
#    t.datetime "created_at",  null: false
#    t.datetime "updated_at",  null: false
#  end


end
