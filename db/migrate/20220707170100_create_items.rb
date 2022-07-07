class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.column :price,       :float
      t.column :name,        :string
      t.column :description, :string
      t.column :images,      :string

      t.column :category_id,   :integer
      t.column :created_by_id, :integer
      t.column :updated_by_id, :integer

      t.foreign_key :categories, column: :category_id
      t.foreign_key :users,      column: :created_by_id
      t.foreign_key :users,      column: :updated_by_id

      t.timestamps
    end
    add_index :items, :name
    add_index :items, :price
  end
end
