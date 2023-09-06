class Product < ApplicationRecord
  belongs_to :category
  has_many :order_products

  validates :name, presence: true
  validates :description, presence: true
  has_one_attached :photo
end
