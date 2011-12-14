class CreatePrices < ActiveRecord::Migration
  def change
    create_table :prices do |t|
      t.references :product
      t.float :price
      t.string :currency

      t.timestamps
    end
    add_index :prices, :product_id
  end
end
