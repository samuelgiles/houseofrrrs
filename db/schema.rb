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

ActiveRecord::Schema.define(version: 20131220000849) do

  create_table "items", force: true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.boolean  "needed"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "items", ["user_id"], name: "index_items_on_user_id"

  create_table "payments", force: true do |t|
    t.integer  "user_id"
    t.integer  "destination_user_id"
    t.decimal  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "payments", ["user_id"], name: "index_payments_on_user_id"

  create_table "purchases", force: true do |t|
    t.decimal  "price"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "item_id"
  end

  add_index "purchases", ["user_id"], name: "index_purchases_on_user_id"

  create_table "shares", force: true do |t|
    t.integer  "user_id"
    t.integer  "purchase_id"
    t.decimal  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "paid"
  end

  add_index "shares", ["purchase_id"], name: "index_shares_on_purchase_id"
  add_index "shares", ["user_id"], name: "index_shares_on_user_id"

  create_table "tasks", force: true do |t|
    t.string   "name"
    t.integer  "slot"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_tasks", force: true do |t|
    t.integer  "user_id"
    t.integer  "task_id"
    t.datetime "scheduled"
    t.datetime "completed"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_tasks", ["task_id"], name: "index_user_tasks_on_task_id"
  add_index "user_tasks", ["user_id"], name: "index_user_tasks_on_user_id"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "pin"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
