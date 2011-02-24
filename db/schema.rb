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

ActiveRecord::Schema.define(:version => 20110223170546) do

  create_table "auction_images", :force => true do |t|
    t.integer  "auction_id"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "auctions", :force => true do |t|
    t.string   "title"
    t.string   "auction_id"
    t.string   "url"
    t.string   "image_icon"
    t.string   "seller"
    t.integer  "page_id"
    t.integer  "rating"
    t.datetime "closed_date"
    t.decimal  "closed_price",  :precision => 10, :scale => 0
    t.decimal  "current_price", :precision => 10, :scale => 0
    t.text     "description"
    t.decimal  "buy_price",     :precision => 10, :scale => 0
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "auctions", ["auction_id"], :name => "index_auctions_on_auction_id"
  add_index "auctions", ["page_id"], :name => "index_auctions_on_page_id"
  add_index "auctions", ["seller"], :name => "index_auctions_on_seller"

  create_table "pages", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.text     "body"
    t.string   "query"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "category"
  end

  create_table "users", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["provider"], :name => "index_users_on_provider"
  add_index "users", ["uid"], :name => "index_users_on_uid"

end
