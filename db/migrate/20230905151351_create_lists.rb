class CreateLists < ActiveRecord::Migration[7.0]
  def change
    create_table :lists do |t|
      t.string :grade
      t.string :name
      t.integer :quantity
      t.references :school, null: false, foreign_key: true

      t.timestamps
    end
  end
end
