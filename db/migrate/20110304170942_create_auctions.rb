class CreateAuctions < ActiveRecord::Migration
  def self.up
    create_table :auctions do |t|
      t.string :title
      t.string :auction_id,       :limit => 20
      t.string :url

      t.timestamps
    end
    
    add_index :auctions, :auction_id
  end

  def self.down
    drop_table :auctions
  end
end
