class CartsController < ApplicationController
  before_action :set_product, only: %i[new create]

  def index
    @carts = current_user.carts.order(id: :desc)
  end

  def new
    @cart = Cart.new
  end

  def add_item
    @cart = Cart.find(params[:id])
    @cart.quantity +=1
    @cart.save
    redirect_to request.referer, notice: "Product successfully added"
  end

  def remove_item
    @cart = Cart.find(params[:id])
    @cart.quantity -=1
    @cart.save
    redirect_to carts_path, notice: "Product successfully removed"
  end

  def create
    @cart = Cart.new
    @cart.quantity = 1
    @cart.user = current_user
    @cart.product = @product
    if @cart.save
      redirect_to @cart, notice: "Product successfully added"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @cart = Cart.find(params[:id])
    # orderProduct.create
    @cart.destroy
    if Cart.count.zero?
      redirect_to root_path
    else
      redirect_to carts_path
    end
  end

  def edit
    @cart = Cart.find(params[:id])
  end

  def update
    @cart = Cart.find(params[:id])
    @cart.update(cart_params)
  end

  def checkout
    # Create a new order based on the user's current cart(s)
    order = current_user.orders.create
    current_user.carts.each do |cart|
      order.order_products.create(product: cart.product, quantity: cart.quantity)
    end

    # Destroy the user's current cart(s) after creating the order
    # current_user.carts.destroy_all

    # Redirect to the orders#show view for the newly created order
    redirect_to order
  end

  # ...


  private

  def set_cart
    @cart = Cart.find(params[:id])
  end

  def set_product
    @product = Product.find(params[:product_id])
  end

  # def product_params
  #   params.require(:product).permit(:name)
  # end
end
