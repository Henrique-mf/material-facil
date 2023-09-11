class ListProduct < ApplicationRecord
  belongs_to :list
  belongs_to :product
  
  validates :quantity, presence: true
end
