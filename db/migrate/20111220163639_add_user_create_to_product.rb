class AddUserCreateToProduct < ActiveRecord::Migration
  def change
    add_column :products, :user_id, :integer
    add_index :products, [:user_id]
  end
  def self.down
    remove_column :products, :user_id
    remove_index :products, [:user_id]
  end
end
