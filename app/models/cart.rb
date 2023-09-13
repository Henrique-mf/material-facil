class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy

  def quantity
    cart_items.sum(:quantity)
  end

  def total_price
    cart_items.sum { |cart_item| cart_item.product.price_cents * cart_item.quantity }
  end
end
