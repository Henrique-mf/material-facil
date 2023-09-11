class Grade < ApplicationRecord
  belongs_to :school
  has_one :list, dependent: :destroy

  validates :name, presence: true
end
