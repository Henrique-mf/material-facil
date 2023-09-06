class List < ApplicationRecord
  belongs_to :grade
  has_many :products

  validates :name, presence: true
  validates :quantity, presence: true
end
