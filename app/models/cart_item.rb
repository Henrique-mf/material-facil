class CartItem < ApplicationRecord
  belongs_to :user
  belongs_to :product
  belongs_to :cart

  def total
    (product.price.to_f / 100) * quantity
  end
end
