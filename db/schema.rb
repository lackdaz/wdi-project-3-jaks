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

ActiveRecord::Schema.define(version: 20170430040512) do

  create_table "addresses", force: :cascade do |t|
    t.string   "address_id"
    t.string   "name"
    t.string   "custid"
    t.float    "locx"
    t.float    "locy"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string   "co_id"
    t.string   "stall"
    t.string   "email"
    t.string   "password"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "contact"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "consumers", force: :cascade do |t|
    t.string   "consumer_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.integer  "contact"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "dboxes", force: :cascade do |t|
    t.string   "dbox_id"
    t.string   "dman_firstname"
    t.string   "dman_lastname"
    t.string   "email"
    t.string   "password"
    t.integer  "contact"
    t.float    "locx"
    t.float    "locy"
    t.integer  "temp"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "flavors", force: :cascade do |t|
    t.string   "flavor_id"
    t.string   "flavor_name"
    t.string   "co_id"
    t.string   "co_name"
    t.integer  "flavor_price"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "icecreams", force: :cascade do |t|
    t.string   "icecream_id"
    t.string   "stall_id"
    t.string   "flavor_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "order_icecreams", force: :cascade do |t|
    t.string   "order_id"
    t.string   "icecream_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "orders", force: :cascade do |t|
    t.string   "order_id"
    t.string   "in_a"
    t.integer  "order_price"
    t.string   "dbox_id"
    t.string   "address_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "stalls", force: :cascade do |t|
    t.string   "stall_id"
    t.string   "co_name"
    t.string   "email"
    t.string   "password"
    t.string   "address"
    t.float    "locx"
    t.float    "locy"
    t.integer  "contact"
    t.string   "owner_firstname"
    t.string   "owner_lastname"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
