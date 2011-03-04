class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.integer :user_id
      t.integer :order_id
      t.datetime :date_req
      t.datetime :date_sent
      t.string :method,           :limit => 10
      t.decimal :quote
      t.integer :ship_address_id
      t.text :remark
      t.text :internal
      t.string :tracking
      t.integer :status,          :default => 0

      t.timestamps
    end
    
    add_index :orders, :order_id
    add_index :orders, :status
  end

  def self.down
    drop_table :orders
  end
end
