class CreateOrderPositions < ActiveRecord::Migration[7.0]
  def change
    create_table :order_positions do |t|
      t.column :order_id, :integer
      t.column :item_id,  :integer
      t.column :quantity, :integer

      t.foreign_key :orders, column: :order_id
      t.foreign_key :items,  column: :item_id

      t.timestamps
    end
  end
end
