class CreateJournals < ActiveRecord::Migration
  def self.up
    create_table :journals do |t|
      t.integer :user_id
      t.decimal :amount,      :default => 0
      t.decimal :balance,     :default => 0
      t.text :description
      t.string :currency,     :default => 'USD'
      t.string :code,         :limit => 2
      t.integer :ref

      t.timestamps
    end
    
    add_index :journals, :code
    add_index :journals, :ref
  end

  def self.down
    drop_table :journals
  end
end
