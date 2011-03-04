class RenameUserIdJournals < ActiveRecord::Migration
  def self.up
    rename_column :journals, :user_id, :account_id
    add_index :journals, :account_id
  end

  def self.down
  end
end
