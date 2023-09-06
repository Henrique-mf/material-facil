class AddFieldToOrder < ActiveRecord::Migration[7.0]
  def change
    add_reference :orders, :user, null: false, foreign_key: true
    add_column :order_products, :price, :integer
    add_column :order_products, :quantity, :integer
  end
end
