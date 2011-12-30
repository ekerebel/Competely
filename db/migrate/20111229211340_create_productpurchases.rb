class CreateProductpurchases < ActiveRecord::Migration
  def change
    create_table :productpurchases do |t|
      t.integer :user_id
      t.integer :product_id
      t.integer :price

      t.timestamps
    end
    add_index :productpurchases, [:user_id, :product_id]
  end
end
