class CartItemsController < ApplicationController
  before_action :set_cart_item_and_cart, only: %i[add_quantity remove_quantity destroy]

  def add_quantity
    @cart_item.quantity += 1
    @cart_item.save
    @cart_item.cart.update(total_price: @cart_item.cart.total_price += @cart_item.product.price_cents)
    redirect_to @cart_item, notice: "Product successfully added"
  end

  def remove_quantity
    @cart_item.quantity -= 1
    @cart_item.save
    @cart_item.cart.update(total_price: @cart_item.cart.total_price -= @cart_item.product.price_cents)
    redirect_to @cart, notice: "Product successfully removed"
  end

  def create
    @product = Product.find(params[:product_id])
    @cart = current_user.current_cart
    @cart_item = CartItem.find_by(user: current_user, cart: @cart, product: @product)
    if @cart_item.nil?
      CartItem.create(user: current_user, cart: @cart, product: @product, quantity: 1)
    else
      @cart_item.update(quantity: @cart_item.quantity + 1)
    end
    if @cart.total_price?
      @cart.update(total_price: @cart.total_price += @product.price_cents)
    else
      @cart.update(total_price: @product.price_cents)
    end
    redirect_to @product, notice: "Product successfully added"
  end

  def destroy
    @cart_item.destroy
  end

  private

  def set_cart_item_and_cart
    @cart_item = CartItem.find(params[:id])
    @cart = @cart_item.cart
  end
end
