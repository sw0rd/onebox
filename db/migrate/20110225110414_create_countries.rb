class CreateCountries < ActiveRecord::Migration
  def self.up
    create_table :countries do |t|
      t.string :iso_name
      t.string :iso
      t.string :name
      t.string :iso3
      t.integer :numcode

      t.timestamps
    end
  end

  def self.down
    drop_table :countries
  end
end
