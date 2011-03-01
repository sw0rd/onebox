class AddNameIndexToSeller < ActiveRecord::Migration
  def self.up
    add_index :sellers, :name
  end

  def self.down
  end
end
