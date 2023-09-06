class OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def new
    @order = order.new
  end

  def create
    @order = Order.new(order_params)
    @order.user = current_user
    if @order.save
      redirect_to @order
    else
      render :new, status: :unprocessable_entity
    end
  end
end
