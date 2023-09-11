class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy

  def quantity
    cart_items.sum(:quantity)
  end
end
