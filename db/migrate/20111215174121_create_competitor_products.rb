class CreateCompetitorProducts < ActiveRecord::Migration
  def change
    create_table :competitor_products do |t|
      t.integer :vendor_product_id
      t.integer :competitor_product_id

      t.timestamps
    end
  end
end
