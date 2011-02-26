class AddPublishedToPages < ActiveRecord::Migration
  def self.up
    add_column :pages, :published, :integer, :default => true
    add_index :pages, :published
  end

  def self.down
    remove_column :pages, :published
  end
end
