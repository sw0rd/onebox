class CreateAuctions < ActiveRecord::Migration
  def self.up
    create_table :auctions do |t|
      t.string :title
      t.string :auction_id
      t.string :url
      t.string :image_icon
      t.string :seller
      t.integer :page_id
      t.integer :rating
      t.datetime :closed_date
      t.decimal :closed_price
      t.decimal :current_price
      t.text :description
      t.decimal :buy_price
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
    
    add_index :auctions, :auction_id
    add_index :auctions, :page_id
    add_index :auctions, :seller
  end

  def self.down
    drop_table :auctions
  end
end
