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

ActiveRecord::Schema.define(version: 20151219211735) do

  create_table "interview_questions", force: :cascade do |t|
    t.integer  "interview_id", limit: 4
    t.integer  "question_id",  limit: 4
    t.string   "comment",      limit: 255
    t.string   "mark",         limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "interviews", force: :cascade do |t|
    t.string   "firstname",    limit: 255
    t.string   "lastname",     limit: 255
    t.string   "target_level", limit: 255
    t.integer  "template_id",  limit: 4
    t.integer  "user_id",      limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "questions", force: :cascade do |t|
    t.text     "content",    limit: 65535, null: false
    t.text     "answer",     limit: 65535
    t.integer  "topic_id",   limit: 4,     null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "level",      limit: 255
  end

  add_index "questions", ["topic_id"], name: "index_questions_on_topic_id", using: :btree

  create_table "questions_templates", id: false, force: :cascade do |t|
    t.integer "template_id", limit: 4
    t.integer "question_id", limit: 4
  end

  create_table "templates", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.integer  "question_id", limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "topics", force: :cascade do |t|
    t.string   "title",              limit: 255, null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name",             limit: 255
    t.string   "last_name",              limit: 255
    t.string   "email",                  limit: 255, default: "",    null: false
    t.boolean  "admin",                              default: false
    t.boolean  "approved",                           default: false
    t.string   "encrypted_password",     limit: 255, default: "",    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "questions", "topics"
end
