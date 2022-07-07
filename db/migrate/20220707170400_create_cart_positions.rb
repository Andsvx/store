class CreateCartPositions < ActiveRecord::Migration[7.0]
  def change
    create_table :cart_positions do |t|
      t.column :cart_id,  :integer
      t.column :item_id,  :integer
      t.column :quantity, :integer

      t.foreign_key :carts, column: :cart_id
      t.foreign_key :items, column: :item_id

      t.timestamps
    end
  end
end
