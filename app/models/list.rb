class List < ApplicationRecord
  belongs_to :grade

  validates :name, presence: true
  validates :quantity, presence: true
end
