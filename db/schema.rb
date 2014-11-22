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

ActiveRecord::Schema.define(version: 20141122134032) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_users", force: true do |t|
    t.string   "name"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "events", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "starts_at"
    t.integer  "admin_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "promo_codes", force: true do |t|
    t.integer  "promocodable_id"
    t.string   "promocodable_type"
    t.string   "code"
    t.integer  "discount_percent"
    t.integer  "total_applies"
    t.integer  "remained_applies"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ticket_types", force: true do |t|
    t.integer  "event_id"
    t.string   "title"
    t.decimal  "price",      precision: 8, scale: 2
    t.integer  "total"
    t.integer  "remained"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tickets", force: true do |t|
    t.integer  "ticket_type_id"
    t.string   "name"
    t.string   "email"
    t.string   "cc_number"
    t.string   "promo_code_id"
    t.decimal  "price",          precision: 8, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tickets", ["cc_number"], name: "index_tickets_on_cc_number", using: :btree
  add_index "tickets", ["ticket_type_id"], name: "index_tickets_on_ticket_type_id", using: :btree

end
