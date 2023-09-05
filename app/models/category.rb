class Category < ApplicationRecord
  has_many :products

  validates :price, presence: true
  validates :name, presence: true
  validates :description, presence: true, length: { minimum: 5 }
end
