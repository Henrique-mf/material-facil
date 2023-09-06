class AddFieldToCarts < ActiveRecord::Migration[7.0]
  def change
    add_reference :carts, :product, null: false, foreign_key: true
    add_reference :carts, :user, null: false, foreign_key: true
  end
end
