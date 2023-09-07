class CategoriesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]
  
  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
  end

  # def search
  #   @search_results = Category.where("name ILIKE ?", "%#{params[:search][:query]}%")
  # end

  private

  def new
  end

  def edit
  end

  def set_category
    @category = Category.find(params[:id])
  end
end
