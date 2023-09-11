class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]
  before_action :set_product, only: %i[show buy_product]

  def index
    @pagy, @products = pagy(Product.all, items: params.fetch(:count, 12))
  end

  def show
    @product = Product.find(params[:id])
    @cart = Cart.new
  end

  def search
    @search_term = params[:search_term]
    @products = Product.search_by_term(@search_term)
  end

  def buy_product
    @cart = Cart.create(user: current_user)
    CartItem.create(user: current_user, cart: @cart, product: @product, quantity: 1)
    redirect_to @cart
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :photo, :price)
  end
end
