class AddStatusToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :status, :integer, :default => 1
    add_index :users, :status
  end

  def self.down
    remove_column :users, :status
  end
end
