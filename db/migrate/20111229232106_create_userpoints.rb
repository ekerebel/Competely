class CreateUserpoints < ActiveRecord::Migration
  def change
    create_table :userpoints do |t|
      t.integer :user_id
      t.integer :points

      t.timestamps
    end
    add_index :userpoints, [:user_id]
  end
end
