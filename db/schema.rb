# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_03_04_055707) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "brands", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "consumptions", force: :cascade do |t|
    t.bigint "stock_id"
    t.integer "quantity"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["stock_id"], name: "index_consumptions_on_stock_id"
  end

  create_table "measurements", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "value"
    t.integer "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_measurements_on_user_id"
  end

  create_table "medicine_types", force: :cascade do |t|
    t.string "name"
    t.string "type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "medicines", force: :cascade do |t|
    t.string "name"
    t.integer "content"
    t.string "unit"
    t.bigint "brand_id"
    t.bigint "medicine_type_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["brand_id"], name: "index_medicines_on_brand_id"
    t.index ["medicine_type_id"], name: "index_medicines_on_medicine_type_id"
  end

  create_table "stocks", force: :cascade do |t|
    t.bigint "user_id"
    t.string "stockable_type"
    t.bigint "stockable_id"
    t.integer "quantity"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["stockable_type", "stockable_id"], name: "index_stocks_on_stockable_type_and_stockable_id"
    t.index ["user_id"], name: "index_stocks_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "surname"
    t.string "email"
    t.string "password_digest"
    t.string "phone"
    t.datetime "birth_date"
    t.datetime "diabetes_discovery_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "consumptions", "stocks"
  add_foreign_key "measurements", "users"
  add_foreign_key "medicines", "brands"
  add_foreign_key "medicines", "medicine_types"
  add_foreign_key "stocks", "users"
end
