class Product < ApplicationRecord
  include PgSearch::Model

  pg_search_scope :search_by_term,
    against: {
      name: 'A',
      description: 'B'
    },
    using: {
      tsearch: {
        any_word: true,
      dictionary: 'english'
      }
    }

  belongs_to :category
  has_many :orders

  validates :name, presence: true
  validates :description, presence: true
  has_one_attached :photo
  monetize :price_cents, as: :price
end
