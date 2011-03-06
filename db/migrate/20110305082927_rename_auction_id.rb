class RenameAuctionId < ActiveRecord::Migration
  def self.up
    rename_column :auctions, :auction_id, :code
    add_index :auctions, :code
  end

  def self.down
  end
end
