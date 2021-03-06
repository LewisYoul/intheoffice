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

ActiveRecord::Schema.define(version: 2022_02_02_174138) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_stat_statements"
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "auto_renew", default: true, null: false
    t.string "stripe_customer_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "plans", force: :cascade do |t|
    t.string "level", null: false
    t.integer "monthly_cost_dollars", null: false
    t.integer "yearly_cost_dollars", null: false
    t.string "stripe_price_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "subscriptions", force: :cascade do |t|
    t.bigint "plan_id"
    t.bigint "account_id"
    t.boolean "auto_renew", null: false
    t.datetime "start_datetime", precision: 6, null: false
    t.datetime "end_datetime", precision: 6, null: false
    t.boolean "active", null: false
    t.string "uid"
    t.string "stripe_subscription_id"
    t.boolean "past_due", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_subscriptions_on_account_id"
    t.index ["plan_id"], name: "index_subscriptions_on_plan_id"
  end

  create_table "user_account_locations", force: :cascade do |t|
    t.bigint "user_account_id", null: false
    t.bigint "location_id", null: false
    t.date "location_date", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "note"
    t.index ["location_id"], name: "index_user_account_locations_on_location_id"
    t.index ["user_account_id"], name: "index_user_account_locations_on_user_account_id"
  end

  create_table "user_accounts", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "account_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "role_id"
    t.bigint "workplace_id"
    t.string "status", default: "active", null: false
    t.index ["account_id"], name: "index_user_accounts_on_account_id"
    t.index ["role_id"], name: "index_user_accounts_on_role_id"
    t.index ["user_id"], name: "index_user_accounts_on_user_id"
    t.index ["workplace_id"], name: "index_user_accounts_on_workplace_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "full_name", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "workplaces", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "account_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_workplaces_on_account_id"
  end

  add_foreign_key "user_account_locations", "locations"
  add_foreign_key "user_account_locations", "user_accounts"
  add_foreign_key "user_accounts", "accounts"
  add_foreign_key "user_accounts", "users"
  add_foreign_key "workplaces", "accounts"
end
