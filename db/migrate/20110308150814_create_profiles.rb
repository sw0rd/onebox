class CreateProfiles < ActiveRecord::Migration
  def self.up
    create_table :profiles do |t|
      t.integer :user_id
      t.string :timezone
      t.integer :primary_address
      t.integer :grade,           :default => 0

      t.timestamps
    end

    add_index :profiles, :user_id
    add_index :profiles, :primary_address    
    add_index :profiles, :grade
  end

  def self.down
    drop_table :profiles
  end
end
