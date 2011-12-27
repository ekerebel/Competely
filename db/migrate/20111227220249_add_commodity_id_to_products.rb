class AddCommodityIdToProducts < ActiveRecord::Migration
  def up
    add_column :products, :commodity_id, :integer
  end
  def down
    remove_column :products, :commodity_id
  end
end
