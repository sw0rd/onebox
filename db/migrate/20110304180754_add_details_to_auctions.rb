class AddDetailsToAuctions < ActiveRecord::Migration
  def self.up
    add_column :auctions, :image_icon, :string
    add_column :auctions, :seller, :string
    add_column :auctions, :description, :text
    add_column :auctions, :closed_date, :datetime
    add_column :auctions, :closed_price, :decimal
    add_column :auctions, :current_price, :decimal
    add_column :auctions, :buy_price, :decimal
    add_column :auctions, :start_time, :datetime
    add_column :auctions, :end_time, :datetime
    add_column :auctions, :location, :string,       :limit => 50
    
    add_index :auctions, :seller
  end

  def self.down
    remove_column :auctions, :location
    remove_column :auctions, :end_time
    remove_column :auctions, :start_time
    remove_column :auctions, :buy_price
    remove_column :auctions, :current_price
    remove_column :auctions, :closed_price
    remove_column :auctions, :closed_date
    remove_column :auctions, :description
    remove_column :auctions, :seller
    remove_column :auctions, :image_icon
  end
end
