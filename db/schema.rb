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

ActiveRecord::Schema.define(version: 20170221131127) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name",       limit: 150
    t.string   "type",       limit: 150
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name"], name: "index_categories_on_name", using: :btree
    t.index ["type"], name: "index_categories_on_type", using: :btree
  end

  create_table "horoscopes", force: :cascade do |t|
    t.string "sign",           limit: 50
    t.string "duration",       limit: 50
    t.text   "horoscope_text"
    t.date   "created_at"
    t.date   "updated_at"
  end

  create_table "notification_categories", force: :cascade do |t|
    t.integer  "notification_id"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["category_id"], name: "index_notification_categories_on_category_id", using: :btree
    t.index ["notification_id"], name: "index_notification_categories_on_notification_id", using: :btree
  end

  create_table "notifications", force: :cascade do |t|
    t.text     "notification_text"
    t.string   "type",              limit: 100
    t.string   "language",          limit: 50
    t.string   "author",            limit: 150
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["language"], name: "index_notifications_on_language", using: :btree
    t.index ["type"], name: "index_notifications_on_type", using: :btree
  end

  create_table "other_details", force: :cascade do |t|
    t.integer "detailable_id"
    t.string  "detailable_type", limit: 50
    t.string  "detail_type",     limit: 150
    t.string  "detail",          limit: 1000
    t.date    "created_at"
    t.date    "updated_at"
    t.index ["detailable_id"], name: "index_other_details_on_detailable_id", using: :btree
    t.index ["detailable_type"], name: "index_other_details_on_detailable_type", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name", limit: 100
    t.string   "last_name",  limit: 100
    t.string   "birth_date", limit: 30
    t.string   "birth_sign", limit: 30
    t.string   "gender",     limit: 1
    t.string   "email",      limit: 255
    t.string   "contact_no", limit: 20
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["contact_no"], name: "index_users_on_contact_no", using: :btree
    t.index ["email"], name: "index_users_on_email", using: :btree
    t.index ["first_name"], name: "index_users_on_first_name", using: :btree
    t.index ["gender"], name: "index_users_on_gender", using: :btree
    t.index ["last_name"], name: "index_users_on_last_name", using: :btree
  end

end
