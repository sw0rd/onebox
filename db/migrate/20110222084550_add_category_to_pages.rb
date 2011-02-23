class AddCategoryToPages < ActiveRecord::Migration
  def self.up
    add_column :pages, :category, :string
  end

  def self.down
    remove_column :pages, :category
  end
end
