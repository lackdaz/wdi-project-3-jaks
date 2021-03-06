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

ActiveRecord::Schema.define(version: 20170511064134) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
    t.string   "lat"
    t.string   "lng"
    t.string   "temp"
    t.integer  "deliveryman_id"
    t.integer  "invoice_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["deliveryman_id"], name: "index_deliveryboxes_on_deliveryman_id", using: :btree
    t.index ["invoice_id"], name: "index_deliveryboxes_on_invoice_id", using: :btree
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

  create_table "invoices", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "delivery_address_id"
    t.string   "status"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.index ["delivery_address_id"], name: "index_invoices_on_delivery_address_id", using: :btree
    t.index ["user_id"], name: "index_invoices_on_user_id", using: :btree
  end

  create_table "orderitems", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "supplier_id"
    t.integer  "flavour_id"
    t.integer  "container_id"
    t.integer  "invoice_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["container_id"], name: "index_orderitems_on_container_id", using: :btree
    t.index ["flavour_id"], name: "index_orderitems_on_flavour_id", using: :btree
    t.index ["invoice_id"], name: "index_orderitems_on_invoice_id", using: :btree
    t.index ["supplier_id"], name: "index_orderitems_on_supplier_id", using: :btree
    t.index ["user_id"], name: "index_orderitems_on_user_id", using: :btree
  end

  create_table "pictures", force: :cascade do |t|
    t.string   "public_id"
    t.integer  "supplier_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.boolean  "profilepic"
    t.index ["supplier_id"], name: "index_pictures_on_supplier_id", using: :btree
  end

  create_table "suppliers", force: :cascade do |t|
    t.string   "name"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "address"
    t.integer  "contact"
    t.float    "lat"
    t.float    "lng"
    t.string   "neighbourhood"
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
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "containers", "suppliers"
  add_foreign_key "delivery_addresses", "users"
  add_foreign_key "deliveryboxes", "deliverymen"
  add_foreign_key "deliveryboxes", "invoices"
  add_foreign_key "flavours", "suppliers"
  add_foreign_key "invoices", "delivery_addresses"
  add_foreign_key "invoices", "users"
  add_foreign_key "orderitems", "containers"
  add_foreign_key "orderitems", "flavours"
  add_foreign_key "orderitems", "invoices"
  add_foreign_key "orderitems", "suppliers"
  add_foreign_key "orderitems", "users"
  add_foreign_key "pictures", "suppliers"
end
