class RatingAnswer < ActiveRecord::Base
  belongs_to :actual_question
  belongs_to :goal

  # => create_table "rating_answers", force: :cascade do |t|
  #    t.integer  "answer"#
  #    t.date     "date"
  #    t.integer  "question_id"
  #    t.integer  "goal_id"
  #    t.datetime "created_at",  null: false
  #    t.datetime "updated_at",  null: false
  #  end



end
