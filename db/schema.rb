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

ActiveRecord::Schema.define(version: 20160822123453) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "boolean_answers", force: :cascade do |t|
    t.boolean  "answer"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "question_id"
  end

  add_index "boolean_answers", ["question_id"], name: "index_boolean_answers_on_question_id", using: :btree

  create_table "checkin_logs", force: :cascade do |t|
    t.date     "date"
    t.integer  "goal_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "checkin_logs", ["goal_id"], name: "index_checkin_logs_on_goal_id", using: :btree

  create_table "comment_answers", force: :cascade do |t|
    t.text     "answer"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "question_id"
  end

  add_index "comment_answers", ["question_id"], name: "index_comment_answers_on_question_id", using: :btree

  create_table "goals", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "frequency"
    t.string   "goaltype"
    t.integer  "user_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.text     "success_description"
  end

  add_index "goals", ["user_id"], name: "index_goals_on_user_id", using: :btree

  create_table "questions", force: :cascade do |t|
    t.string   "question"
    t.string   "qntype"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text     "scale"
    t.integer  "qnorder"
    t.integer  "goal_id"
  end

  add_index "questions", ["goal_id"], name: "index_questions_on_goal_id", using: :btree

  create_table "rating_answers", force: :cascade do |t|
    t.integer  "answer"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "question_id"
  end

  add_index "rating_answers", ["question_id"], name: "index_rating_answers_on_question_id", using: :btree

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

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
    t.string   "email",                  default: "", null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "provider"
    t.string   "uid"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "checkin_logs", "goals"
  add_foreign_key "goals", "users"
end
