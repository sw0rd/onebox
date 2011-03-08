class AddPublishedToPages < ActiveRecord::Migration
  def self.up
    add_column :pages, :published, :integer, :default => 1
    add_index :pages, :published
  end

  def self.down
    remove_column :pages, :published
    remove_index :pages, :published
  end
end
