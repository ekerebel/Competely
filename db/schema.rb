# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111229232106) do

  create_table "categories", :force => true do |t|
    t.string   "title"
    t.string   "category_type"
    t.integer  "parent"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["parent"], :name => "index_categories_on_parent"

  create_table "competitor_products", :force => true do |t|
    t.integer  "vendor_product_id"
    t.integer  "competitor_product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "prices", :force => true do |t|
    t.integer  "product_id"
    t.float    "price"
    t.string   "currency"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "prices", ["product_id"], :name => "index_prices_on_product_id"

  create_table "productpurchases", :force => true do |t|
    t.integer  "user_id"
    t.integer  "product_id"
    t.integer  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "productpurchases", ["user_id", "product_id"], :name => "index_productpurchases_on_user_id_and_product_id"

  create_table "products", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "manufacturer"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "category_id"
  end

  add_index "products", ["user_id"], :name => "index_products_on_user_id"

  create_table "userpoints", :force => true do |t|
    t.integer  "user_id"
    t.integer  "points"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "userpoints", ["user_id"], :name => "index_userpoints_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "middle_name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password"
    t.string   "salt"
    t.string   "screen_name"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
