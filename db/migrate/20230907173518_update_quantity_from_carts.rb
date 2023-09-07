class UpdateQuantityFromCarts < ActiveRecord::Migration[7.0]
  def change
    change_column :carts, :quantity, 'integer USING CAST(quantity AS integer)'
  end
end
