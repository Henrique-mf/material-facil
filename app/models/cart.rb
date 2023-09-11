class Cart < ApplicationRecord
  belongs_to :user
  belongs_to :product

  def total_price
    quantity * product.price
  end
end
