# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160727111303) do

  create_table "actual_questions", force: :cascade do |t|
    t.integer "goal_id"
    t.integer "question_id"
    t.integer "qnorder"
  end

  add_index "actual_questions", ["goal_id"], name: "index_actual_questions_on_goal_id"
  add_index "actual_questions", ["question_id"], name: "index_actual_questions_on_question_id"

  create_table "boolean_answers", force: :cascade do |t|
    t.boolean  "answer"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "actual_question_id"
  end

  add_index "boolean_answers", ["actual_question_id"], name: "index_boolean_answers_on_actual_question_id"

  create_table "comment_answers", force: :cascade do |t|
    t.text     "answer"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "actual_question_id"
  end

  add_index "comment_answers", ["actual_question_id"], name: "index_comment_answers_on_actual_question_id"

  create_table "goals", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "frequency"
    t.string   "goaltype"
    t.integer  "user_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.datetime "last_checkin"
    t.integer  "checkin_count",       default: 0
    t.text     "success_description"
  end

  add_index "goals", ["user_id"], name: "index_goals_on_user_id"

  create_table "questions", force: :cascade do |t|
    t.string   "question"
    t.string   "qntype"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.text     "scale"
    t.integer  "default_order"
  end

  create_table "rating_answers", force: :cascade do |t|
    t.integer  "answer"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "actual_question_id"
  end

  add_index "rating_answers", ["actual_question_id"], name: "index_rating_answers_on_actual_question_id"

  create_table "template_questions", force: :cascade do |t|
    t.string   "text"
    t.string   "qntype"
    t.string   "scale"
    t.integer  "default_order"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
