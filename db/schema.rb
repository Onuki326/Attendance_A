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

ActiveRecord::Schema.define(version: 20181115130442) do

  create_table "attendances", force: :cascade do |t|
    t.date "day"
    t.datetime "arrival"
    t.datetime "leave"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "sperior_id"
    t.string "type"
    t.text "remark"
    t.boolean "yesterday_state", default: false
    t.integer "state", default: 0
    t.boolean "change_state", default: false
    t.datetime "finish_at"
    t.index ["user_id", "created_at"], name: "index_attendances_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_attendances_on_user_id"
  end

  create_table "bases", force: :cascade do |t|
    t.string "base_number"
    t.string "base_name"
    t.string "attendance_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "requester_id"
    t.integer "requested_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["requested_id"], name: "index_relationships_on_requested_id"
    t.index ["requester_id", "requested_id"], name: "index_relationships_on_requester_id_and_requested_id", unique: true
    t.index ["requester_id"], name: "index_relationships_on_requester_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "admin", default: false
    t.string "affiliation"
    t.string "employee_number"
    t.string "employee_id"
    t.datetime "basic_working_hours"
    t.datetime "starting_work_at"
    t.datetime "finishing_work_at"
    t.boolean "sperior"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
