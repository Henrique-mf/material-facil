class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]

  def index
    @pagy, @products = pagy(Product.all, items: params.fetch(:count, 10))
  end

  def show
    @product = Product.find(params[:id])
    @cart = Cart.new
  end

  def search
    @search_term = params[:search_term]
    @products = Product.search_by_term(@search_term)
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :photo, :price)
  end
end
