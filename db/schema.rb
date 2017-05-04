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

ActiveRecord::Schema.define(version: 20170503034958) do

  create_table "all_flavours", force: :cascade do |t|
    t.string   "name"
    t.integer  "price"
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
    t.string   "firstname"
    t.string   "lastname"
    t.string   "email"
    t.integer  "contact"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
  end

  create_table "delivery_addresses", force: :cascade do |t|
    t.integer  "consumer_id"
    t.string   "address"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["consumer_id"], name: "index_delivery_addresses_on_consumer_id"
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
    t.string   "name"
    t.string   "address"
    t.integer  "contact"
    t.string   "email"
    t.string   "password_digest"
    t.string   "website"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.integer  "consumer_id"
    t.integer  "address_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["address_id"], name: "index_transactions_on_address_id"
    t.index ["consumer_id"], name: "index_transactions_on_consumer_id"
  end

end
