# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_02_05_180107) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.string "title", null: false
    t.string "overview", null: false
    t.string "body", null: false
    t.string "image"
    t.integer "manpower_needed", null: false
    t.string "location", null: false
    t.bigint "time_start", null: false
    t.bigint "time_end", null: false
    t.bigint "created_at"
    t.bigint "updated_at"
  end

  create_table "applications", primary_key: ["user_id", "activity_id"], force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "activity_id", null: false
    t.bigint "created_at"
    t.bigint "updated_at"
    t.boolean "accepted", default: false, null: false
    t.decimal "id", null: false
    t.index ["activity_id"], name: "index_applications_on_activity_id"
    t.index ["id"], name: "index_applications_on_id", unique: true
    t.index ["user_id"], name: "index_applications_on_user_id"
  end

  execute "CREATE SEQUENCE application_id OWNED BY applications.id"
  execute "ALTER TABLE applications ALTER COLUMN id SET DEFAULT nextval('application_id')"

  create_table "attendances", primary_key: ["user_id", "activity_id"], force: :cascade do |t|
    t.boolean "attended"
    t.bigint "user_id", null: false
    t.bigint "activity_id", null: false
    t.bigint "created_at"
    t.bigint "updated_at"
    t.bigint "applications_id", null: false
    t.index ["activity_id"], name: "index_attendances_on_activity_id"
    t.index ["applications_id"], name: "index_attendances_on_applications_id"
    t.index ["user_id"], name: "index_attendances_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: true
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "email"
    t.string "image"
    t.string "full_name", null: false
    t.boolean "is_male", null: false
    t.integer "age", null: false
    t.boolean "is_admin", default: false, null: false
    t.json "tokens"
    t.bigint "handphone"
    t.bigint "created_at"
    t.bigint "updated_at"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  add_foreign_key "applications", "activities"
  add_foreign_key "applications", "users"
  add_foreign_key "attendances", "activities"
  add_foreign_key "attendances", "applications", column: "applications_id"
  add_foreign_key "attendances", "users"
end
