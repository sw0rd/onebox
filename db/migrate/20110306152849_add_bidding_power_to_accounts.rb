class AddBiddingPowerToAccounts < ActiveRecord::Migration
  def self.up
    add_column :accounts, :power, :decimal
  end

  def self.down
    remove_column :accounts, :power
  end
end
