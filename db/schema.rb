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

ActiveRecord::Schema.define(version: 20160607153824) do

  create_table "comments", force: :cascade do |t|
    t.text     "content"
    t.integer  "message_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "comments", ["message_id"], name: "index_comments_on_message_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "messages", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "user_id"
  end

  create_table "quest_assignments", force: :cascade do |t|
    t.boolean  "completed",  default: false
    t.integer  "quest_id"
    t.integer  "user_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "quests", force: :cascade do |t|
    t.string   "quest_type"
    t.string   "title"
    t.string   "description"
    t.datetime "deadline"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "quests", ["created_at"], name: "index_quests_on_creator_id_and_created_at"
  add_index "quests", ["user_id", "created_at"], name: "index_quests_on_user_id_and_created_at"
  add_index "quests", ["user_id"], name: "index_quests_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "identity_no"
    t.integer  "lvl",             default: 1
    t.integer  "exp",             default: 0
    t.boolean  "admin",           default: false
    t.string   "password_digest"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "remember_digest"
    t.integer  "hp",              default: 100
    t.integer  "mp",              default: 30
    t.integer  "str",             default: 10
    t.integer  "agi",             default: 10
    t.integer  "vit",             default: 10
    t.integer  "int",             default: 10
    t.integer  "luck",            default: 34
    t.integer  "sp",              default: 3
    t.integer  "curr_hp",         default: 100
    t.integer  "curr_mp",         default: 30
    t.integer  "hp_job",          default: 0
    t.integer  "mp_job",          default: 0
    t.integer  "str_job",         default: 0
    t.integer  "agi_job",         default: 0
    t.integer  "vit_job",         default: 0
    t.integer  "int_job",         default: 0
    t.integer  "hp_eqp",          default: 0
    t.integer  "mp_eqp",          default: 0
    t.integer  "str_eqp",         default: 0
    t.integer  "agi_eqp",         default: 0
    t.integer  "vit_eqp",         default: 0
    t.integer  "int_eqp",         default: 0
    t.string   "job",             default: "Apprentice"
    t.string   "clan",            default: "Neutral"
  end

  add_index "users", ["identity_no"], name: "index_users_on_identity_no", unique: true

end
