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

ActiveRecord::Schema[8.0].define(version: 2025_06_24_174548) do
  create_table "categories", force: :cascade do |t|
    t.string "name", limit: 100, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

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

  create_table "orders", force: :cascade do |t|
    t.integer "customer_id", null: false
    t.integer "province_id", null: false
    t.decimal "subtotal", precision: 10, scale: 2, null: false
    t.decimal "gst_amount", precision: 10, scale: 2
    t.decimal "pst_amount", precision: 10, scale: 2
    t.decimal "hst_amount", precision: 10, scale: 2
    t.decimal "tax_total", precision: 10, scale: 2
    t.decimal "total_price", precision: 10, scale: 2, null: false
    t.string "payment_id", limit: 255
    t.string "payment_provider", limit: 50
    t.string "order_status", limit: 50, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_orders_on_customer_id"
    t.index ["province_id"], name: "index_orders_on_province_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name", limit: 100, null: false
    t.text "description"
    t.decimal "current_price", precision: 10, scale: 2, null: false
    t.boolean "on_sale", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "provinces", force: :cascade do |t|
    t.string "name"
    t.decimal "gst_rate", precision: 10, scale: 2
    t.decimal "pst_rate", precision: 10, scale: 2
    t.decimal "hst_rate", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "customers", "provinces"
  add_foreign_key "orders", "customers"
  add_foreign_key "orders", "provinces"
end
