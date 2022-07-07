class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.column :user_id,      :integer
      t.column :address,      :string
      t.column :phone_number, :string

      t.foreign_key :users, column: :user_id

      t.timestamps
    end
  end
end
