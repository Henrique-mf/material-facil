class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  after_create :create_cart

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, :last_name, :phone, :address, presence: true
  has_one_attached :photo
  has_many :orders
  has_many :carts
  has_many :cart_items
  has_many :products, through: :cart_items

  def create_cart
    puts 'creating cart'
    Cart.create(user: self)
  end

  def current_cart
    cart = carts.where(closed_at: nil).last
    if cart.nil?
      cart = Cart.create(user: self)
    end
    cart
  end
end
