class AddTotalPriceToCart < ActiveRecord::Migration[7.0]
  def change
    add_column :carts, :total_price, :integer
  end
end
