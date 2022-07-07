class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.column :user_id, :integer
      t.column :item_id, :integer
      t.column :text,    :text

      t.foreign_key :users, column: :user_id
      t.foreign_key :items, column: :item_id

      t.timestamps
    end
  end
end
