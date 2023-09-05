class List < ApplicationRecord
  belongs_to :school

  validates :grade, presence: true
  validates :name, presence: true
  validates :quantity, presence: true
end
