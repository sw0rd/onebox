class AddSellerToPages < ActiveRecord::Migration
  def self.up
    add_column :pages, :seller_id, :integer
  end

  def self.down
    remove_column :pages, :seller_id
  end
end
