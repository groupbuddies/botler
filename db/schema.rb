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

ActiveRecord::Schema.define(version: 20150515134224) do

  create_table "categories", force: :cascade do |t|
    t.string  "name"
    t.integer "category_id"
  end

  add_index "categories", ["category_id"], name: "index_categories_on_category_id"
  add_index "categories", ["name"], name: "index_categories_on_name", unique: true

  create_table "expenses", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "periodic_expense_id"
    t.float    "amount"
    t.date     "paid_on"
    t.integer  "category_id"
  end

  add_index "expenses", ["category_id"], name: "index_expenses_on_category_id"
  add_index "expenses", ["periodic_expense_id"], name: "index_expenses_on_periodic_expense_id"

  create_table "periodic_expenses", force: :cascade do |t|
    t.string   "name"
    t.float    "amount"
    t.string   "period"
    t.integer  "user_id"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "last_paid_on"
    t.integer  "category_id"
  end

  add_index "periodic_expenses", ["category_id"], name: "index_periodic_expenses_on_category_id"

  create_table "receipts", force: :cascade do |t|
    t.string  "picture",    null: false
    t.integer "expense_id", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email",                  default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
