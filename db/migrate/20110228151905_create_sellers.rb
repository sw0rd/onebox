class CreateSellers < ActiveRecord::Migration
  def self.up
    create_table :sellers do |t|
      t.string :name
      t.integer :rating
      t.integer :order_count
      t.integer :block,         :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :sellers
  end
end
