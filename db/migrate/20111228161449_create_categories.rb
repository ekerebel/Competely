class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.string :title
      t.string :type
      t.integer :parent
      t.timestamps
    end
    add_index :categories, [:parent]
  end
  def self.down
    drop_table :categories 
  end
end
