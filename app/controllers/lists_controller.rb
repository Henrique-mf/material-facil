class ListsController < ApplicationController
  before_action :set_list

  def index
    @lists = List.all
  end

  def show
    @list = List.find(params[:id])
  end

  private

  def list_params
    params.require(:list).permit(:name)
  end

  def set_list
    @list = List.find(params[:id])
  end
end
