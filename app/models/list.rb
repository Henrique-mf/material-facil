class List < ApplicationRecord
  belongs_to :grade
  has_many :list_products, dependent: :destroy
  has_many :products, through: :list_products

  validates :name, presence: true
end
