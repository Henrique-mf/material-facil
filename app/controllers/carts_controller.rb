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

  def add_list_to_cart
    @list = List.find(params[:list_id])
    @list.list_products.each do |item|
      cart = Cart.find_by(user_id: current_user.id, product_id: item.product.id)
      if cart.nil?
        cart = Cart.new
        cart.quantity = item.quantity
        cart.user = current_user
        cart.product = item.product
        cart.save
      else
        cart.quantity += item.quantity
        cart.save
      end
    end
    redirect_to carts_path, notice: "List successfully added"
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

  def clear_cart
    current_user.carts.destroy_all
    redirect_to carts_path, notice: "Cart successfully cleared"
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
    current_user.carts.each do |cart|
      Order.create(product: cart.product, quantity: cart.quantity, user: current_user)
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
