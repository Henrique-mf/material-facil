class CategoriesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]

  def index
    @pagy, @categories = pagy(Category.all, items: params.fetch(:count, 6))
  end

  def show
    @category = Category.find(params[:id])
  @pagy, @products = pagy(@category.products, items: params.fetch(:count, 6))
  end

  private

  def new
  end

  def edit
  end

  def set_category
    @category = Category.find(params[:id])
  end
end
