class CreateCommodities < ActiveRecord::Migration
  def self.up
    create_table :commodities do |t|
      t.string :title
      t.integer :segment_id
      t.string :segment_title
      t.integer :family_id
      t.string :family_title
      t.integer :class_id
      t.string :class_title

      t.timestamps
    end
    add_index :commodities,[:segment_id]
    add_index :commodities,[:family_id]
    add_index :commodities,[:class_id]
  end
  def self.down
  	drop_table :commodities
  end
  
end
