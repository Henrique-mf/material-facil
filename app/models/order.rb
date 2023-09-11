class Order < ApplicationRecord
  belongs_to :user
  belongs_to :product

  monetize :amount_cents
  has_many :carts, through: :users
end
