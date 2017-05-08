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

ActiveRecord::Schema.define(version: 20170508062246) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "all_flavours", force: :cascade do |t|
    t.string   "name"
    t.float    "price"
    t.integer  "supplier_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["supplier_id"], name: "index_all_flavours_on_supplier_id", using: :btree
  end

  create_table "containers", force: :cascade do |t|
    t.string   "name"
    t.float    "price"
    t.integer  "supplier_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["supplier_id"], name: "index_containers_on_supplier_id", using: :btree
  end

  create_table "delivery_addresses", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_delivery_addresses_on_user_id", using: :btree
  end

  create_table "deliveryboxes", force: :cascade do |t|
    t.string   "locX"
    t.string   "locY"
    t.string   "temperature"
    t.integer  "transaction_id"
    t.integer  "deliveryman_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["deliveryman_id"], name: "index_deliveryboxes_on_deliveryman_id", using: :btree
    t.index ["transaction_id"], name: "index_deliveryboxes_on_transaction_id", using: :btree
  end

  create_table "deliverymen", force: :cascade do |t|
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
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_deliverymen_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_deliverymen_on_reset_password_token", unique: true, using: :btree
  end

  create_table "flavours", force: :cascade do |t|
    t.string   "name"
    t.float    "price"
    t.string   "image"
    t.integer  "supplier_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["supplier_id"], name: "index_flavours_on_supplier_id", using: :btree
  end

  create_table "flavours_orders", id: false, force: :cascade do |t|
    t.integer "order_id",   null: false
    t.integer "flavour_id", null: false
  end

  create_table "installs", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "firstname"
    t.string   "lastname"
    t.integer  "contact"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_installs_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_installs_on_reset_password_token", unique: true, using: :btree
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "all_icecream_container_id"
    t.integer  "transaction_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["all_icecream_container_id"], name: "index_orders_on_all_icecream_container_id", using: :btree
    t.index ["transaction_id"], name: "index_orders_on_transaction_id", using: :btree
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
    t.index ["email"], name: "index_suppliers_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_suppliers_on_reset_password_token", unique: true, using: :btree
  end

  create_table "transactions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "delivery_address_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.index ["delivery_address_id"], name: "index_transactions_on_delivery_address_id", using: :btree
    t.index ["user_id"], name: "index_transactions_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "firstname"
    t.string   "lastname"
    t.integer  "contact"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "containers", "suppliers"
  add_foreign_key "deliveryboxes", "deliverymen"
  add_foreign_key "deliveryboxes", "transactions"
end
