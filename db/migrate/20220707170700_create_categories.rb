class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|
      t.string :name
      t.integer :parent_id, null: true,  index: true
      t.integer :lft,       null: false, index: true
      t.integer :rgt,       null: false, index: true

      t.foreign_key :categories, column: :parent_id

      t.timestamps
    end
    add_index :categories, :name
  end
end
