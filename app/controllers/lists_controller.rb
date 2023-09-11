class ListsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]
  before_action :set_list

  def index
    @lists = List.all
  end

  def show
    @list = List.find(params[:id])
    @list_items = @list.list_products.includes(:product)
  end

  private

  def list_params
    params.require(:list).permit(:name, :quantity, :grade_id)
  end

  def set_list
    @list = List.find(params[:id])
  end
end
