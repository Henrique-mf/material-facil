class CreateListProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :list_products do |t|

      t.references :list, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.integer :quantity, default: 0

      t.timestamps
    end
  end
end
