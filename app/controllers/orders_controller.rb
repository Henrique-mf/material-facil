class OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    @order = order.new
  end

  def create
    @order = Order.new
    @order.user = current_user
    current_user.carts.each do |cart|
      ord_prod = OrderProduct.new(price: cart.product.price)
      ord_prod.order = @order
      ord_prod.product = cart.product
      ord_prod.save
      cart.destroy
    end
    current_user.carts.destroy_all
    if @order.save
      redirect_to @order
    else
      render :new, status: :unprocessable_entity
    end
  end
end
