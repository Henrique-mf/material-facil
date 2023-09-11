class CartsController < ApplicationController
  before_action :set_cart, only: %i[show edit update destroy clear_cart checkout]

  def index
    @carts = current_user.carts.order(id: :desc)
  end

  def show
    @cart = current_user.current_cart
  end

  def new
    @cart = Cart.new
  end

  def add_list_to_cart
    @list = List.find(params[:list_id])
    cart = current_user.current_cart
    if cart.nil?
      cart = Cart.create(user: current_user)
    end
    @list.list_products.each do |item|
      cart_item = CartItem.find_by(user: current_user, cart: cart, product: item.product)
      if cart_item.nil?
        CartItem.create(user: current_user, cart: cart, product: item.product, quantity: item.quantity)
      else
        cart_item.update(quantity: cart_item.quantity + item.quantity)
      end
    end
    redirect_to cart_path(cart), notice: "List successfully added"
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

  def clear_cart
    @cart.cart_items.destroy_all
    redirect_to @cart, notice: "Cart successfully cleared"
  end

  def edit
  end

  def update
    @cart.update(cart_params)
  end

  def checkout

    @cart_items = @cart.cart_items.includes(:product)
    # Create a new order based on the user's current cart(s)
    # current_user.carts.each do |cart|
    #   Order.create(product: cart.product, quantity: cart.quantity, user: current_user)
    # end

    # # Destroy the user's current cart(s) after creating the order
    # # current_user.carts.destroy_all

    # # Redirect to the orders#show view for the newly created order
    # redirect_to order
  end

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
