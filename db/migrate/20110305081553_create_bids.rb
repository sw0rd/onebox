class CreateBids < ActiveRecord::Migration
  def self.up
    create_table :bids do |t|
      t.integer :auction_id
      t.integer :user_id
      t.decimal :bid_price
      t.string :status,       :limit => 10, :default => 'bidding'
      t.integer :active,      :default => true

      t.timestamps
    end
    
    add_index :bids, :auction_id
    add_index :bids, :user_id
    add_index :bids, :status
  end

  def self.down
    drop_table :bids
  end
end
