class CreateCarts < ActiveRecord::Migration[7.0]
  def change
    create_table :carts do |t|
      t.column :user_id, :integer

      t.foreign_key :users, column: :user_id
    end
  end
end
