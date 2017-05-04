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

ActiveRecord::Schema.define(version: 20170504104648) do

  create_table "all_flavours", force: :cascade do |t|
    t.string   "name"
    t.float    "price"
    t.integer  "supplier_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["supplier_id"], name: "index_all_flavours_on_supplier_id"
  end

  create_table "all_icecream_containers", force: :cascade do |t|
    t.string   "name"
    t.float    "price"
    t.integer  "supplier_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["supplier_id"], name: "index_all_icecream_containers_on_supplier_id"
  end

  create_table "consumers", force: :cascade do |t|
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
    t.index ["email"], name: "index_consumers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_consumers_on_reset_password_token", unique: true
  end

  create_table "delivery_addresses", force: :cascade do |t|
    t.integer  "consumer_id"
    t.string   "address"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["consumer_id"], name: "index_delivery_addresses_on_consumer_id"
  end

  create_table "flavours_orders", id: false, force: :cascade do |t|
    t.integer "order_id",   null: false
    t.integer "flavour_id", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "all_icecream_container_id"
    t.integer  "transaction_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["all_icecream_container_id"], name: "index_orders_on_all_icecream_container_id"
    t.index ["transaction_id"], name: "index_orders_on_transaction_id"
  end

  create_table "suppliers", force: :cascade do |t|
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
    t.index ["email"], name: "index_suppliers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_suppliers_on_reset_password_token", unique: true
  end

  create_table "transactions", force: :cascade do |t|
    t.integer  "consumer_id"
    t.integer  "delivery_address_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.index ["consumer_id"], name: "index_transactions_on_consumer_id"
    t.index ["delivery_address_id"], name: "index_transactions_on_delivery_address_id"
  end

end
