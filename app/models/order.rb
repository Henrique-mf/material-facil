class Order < ApplicationRecord
  belongs_to :user
  belongs_to :cart
  # belongs_to :product

  monetize :amount_cents

end
