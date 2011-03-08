class AddPowerDefaultToAccounts < ActiveRecord::Migration
  def self.up
    remove_column :accounts, :power
    add_column :accounts, :power, :decimal, :default => 0
  end

  def self.down
    remove_column :accounts, :power
    add_column :accounts, :power
  end
end
