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

ActiveRecord::Schema.define(version: 20181020135024) do

  create_table "attendances", force: :cascade do |t|
    t.date "day"
    t.datetime "arrival"
    t.datetime "leave"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "created_at"], name: "index_attendances_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_attendances_on_user_id"
  end

  create_table "basictimes", force: :cascade do |t|
    t.datetime "basic_working_hours"
    t.datetime "starting_work_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "finishing_work_at"
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
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
