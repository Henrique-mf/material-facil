class List < ApplicationRecord
  serialize :product_ids, Array
  belongs_to :grade
  has_many :products

  validates :name, presence: true
  validates :quantity, presence: true
end
