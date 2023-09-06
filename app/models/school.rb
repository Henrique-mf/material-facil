class School < ApplicationRecord
  has_many :grades

  validates :name, presence: true
  has_one_attached :photo
end
