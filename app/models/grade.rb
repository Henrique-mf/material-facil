class Grade < ApplicationRecord
  belongs_to :school
  has_many :lists, dependent: :destroy

  validates :name, presence: true
end
