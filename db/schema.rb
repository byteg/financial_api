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

ActiveRecord::Schema[8.0].define(version: 2025_05_30_154637) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "balance_transactions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "counterparty_id"
    t.integer "amount_cents", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "transaction_type", null: false
    t.index ["counterparty_id"], name: "index_balance_transactions_on_counterparty_id"
    t.index ["user_id"], name: "index_balance_transactions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.integer "amount_cents", default: 0
    t.string "jti", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["jti"], name: "index_users_on_jti", unique: true
  end

  add_foreign_key "balance_transactions", "users"
end
