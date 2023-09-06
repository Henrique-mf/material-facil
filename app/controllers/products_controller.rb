class ProductsController < ApplicationController
  def index
    @products = Product.all
    @pagy, @products = pagy @products, items: params.fetch(:count, 10)
  end

  def show
    @product = Product.find(params[:id])
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
    params.require(:product).permit(:name, :description, :photo)
  end
end
