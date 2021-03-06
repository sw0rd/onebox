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

ActiveRecord::Schema.define(:version => 20110308150814) do

  create_table "accounts", :force => true do |t|
    t.integer  "user_id"
    t.decimal  "balance",    :precision => 10, :scale => 0, :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "power",      :precision => 10, :scale => 0, :default => 0
  end

  create_table "addresses", :force => true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
    t.integer  "country_id"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "auctions", :force => true do |t|
    t.string   "title"
    t.string   "code",          :limit => 20
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_icon"
    t.string   "seller"
    t.text     "description"
    t.datetime "closed_date"
    t.decimal  "closed_price",                :precision => 10, :scale => 0
    t.decimal  "current_price",               :precision => 10, :scale => 0
    t.decimal  "buy_price",                   :precision => 10, :scale => 0
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "location",      :limit => 50
  end

  add_index "auctions", ["code"], :name => "index_auctions_on_auction_id"
  add_index "auctions", ["code"], :name => "index_auctions_on_code"
  add_index "auctions", ["seller"], :name => "index_auctions_on_seller"

  create_table "bids", :force => true do |t|
    t.integer  "auction_id"
    t.integer  "user_id"
    t.decimal  "bid_price",                :precision => 10, :scale => 0
    t.string   "status",     :limit => 10,                                :default => "bidding"
    t.integer  "active",                                                  :default => 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bids", ["auction_id"], :name => "index_bids_on_auction_id"
  add_index "bids", ["status"], :name => "index_bids_on_status"
  add_index "bids", ["user_id"], :name => "index_bids_on_user_id"

  create_table "countries", :force => true do |t|
    t.string   "iso_name"
    t.string   "iso"
    t.string   "name"
    t.string   "iso3"
    t.integer  "numcode"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "journals", :force => true do |t|
    t.integer  "account_id"
    t.decimal  "amount",      :precision => 10, :scale => 0, :default => 0
    t.decimal  "balance",     :precision => 10, :scale => 0, :default => 0
    t.text     "description"
    t.string   "currency",                                   :default => "USD"
    t.string   "code"
    t.integer  "ref"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "journals", ["account_id"], :name => "index_journals_on_account_id"
  add_index "journals", ["code"], :name => "index_journals_on_code"
  add_index "journals", ["ref"], :name => "index_journals_on_ref"

  create_table "orders", :force => true do |t|
    t.integer  "user_id"
    t.integer  "order_id"
    t.datetime "date_req"
    t.datetime "date_sent"
    t.string   "method",          :limit => 10
    t.decimal  "quote",                         :precision => 10, :scale => 0
    t.integer  "ship_address_id"
    t.text     "remark"
    t.text     "internal"
    t.string   "tracking"
    t.integer  "status",                                                       :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "orders", ["order_id"], :name => "index_orders_on_order_id"
  add_index "orders", ["status"], :name => "index_orders_on_status"

  create_table "pages", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.text     "body"
    t.string   "query"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "category"
    t.integer  "published",  :default => 1
    t.integer  "pagetype",   :default => 0
    t.integer  "seller_id"
  end

  add_index "pages", ["pagetype"], :name => "index_pages_on_pagetype"
  add_index "pages", ["published"], :name => "index_pages_on_published"

  create_table "profiles", :force => true do |t|
    t.integer  "user_id"
    t.string   "timezone"
    t.integer  "primary_address"
    t.integer  "grade",           :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "profiles", ["grade"], :name => "index_profiles_on_grade"
  add_index "profiles", ["primary_address"], :name => "index_profiles_on_primary_address"
  add_index "profiles", ["user_id"], :name => "index_profiles_on_user_id"

  create_table "sellers", :force => true do |t|
    t.string   "name"
    t.integer  "rating"
    t.integer  "order_count"
    t.integer  "block"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sellers", ["name"], :name => "index_sellers_on_name"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
    t.integer  "status",     :default => 1
  end

  add_index "users", ["provider"], :name => "index_users_on_provider"
  add_index "users", ["status"], :name => "index_users_on_status"
  add_index "users", ["uid"], :name => "index_users_on_uid"

end
