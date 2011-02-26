class AddTypeToPages < ActiveRecord::Migration
  def self.up
    add_column :pages, :type, :integer, :default => 0
    add_index :pages, :type
  end

  def self.down
    remove_column :pages, :type
  end
end
