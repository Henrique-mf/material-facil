class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def search
    @search_results = Product.where("name ILIKE ?", "%#{params[:search][:query]}%")
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  # def product_params
  #   params.require(:product).permit(:name)
  # end
end
