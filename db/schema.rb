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

ActiveRecord::Schema[8.0].define(version: 2025_06_24_145858) do
  create_table "customers", force: :cascade do |t|
    t.integer "province_id", null: false
    t.string "first_name", limit: 50, null: false
    t.string "last_name", limit: 50, null: false
    t.string "email", limit: 50, null: false
    t.string "phone", limit: 20
    t.string "encrypted_password", limit: 100, null: false
    t.string "address", limit: 255, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["province_id"], name: "index_customers_on_province_id"
  end

  create_table "provinces", primary_key: "province_id", force: :cascade do |t|
    t.string "name", limit: 50, null: false
    t.decimal "gst_rate", precision: 10, scale: 2
    t.decimal "pst_rate", precision: 10, scale: 2
    t.decimal "hst_rate", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "customers", "provinces"
end
