class AddIndexToUsers < ActiveRecord::Migration
  def self.up
    add_index :users, :provider
    add_index :users, :uid
  end

  def self.down
  end
end
