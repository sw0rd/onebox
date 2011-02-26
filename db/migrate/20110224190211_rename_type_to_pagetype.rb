class RenameTypeToPagetype < ActiveRecord::Migration
  def self.up
    rename_column :pages, :type, :pagetype
    remove_index :pages, :type
    add_index :pages, :pagetype
  end

  def self.down
  end
end
