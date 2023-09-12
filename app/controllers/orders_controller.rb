class OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def new_index
    @orders = Order.where(user: current_user)
  end

  def show
    @order = current_user.orders.find(params[:id])
  end

  def new
    @order = order.new
  end

  def create
    cart = Cart.find(params[:cart_id])
    order = Order.create(cart: cart, amount_cents: cart.total_price, state: 'pending', user: current_user)

    # Build an array of line items with product names
    line_items = cart.cart_items.map do |cart_item|
      {
        price_data: {
          unit_amount: cart_item.product.price_cents, # Use the product's price
          currency: 'usd',
          product_data: {
            name: cart_item.product.name, # Include the product name
            images: [cart_item.product.photo.key]
          },
        },
        quantity: cart_item.quantity
      }
    end

    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: line_items, # Use the updated line_items array
      mode: 'payment',
      success_url: order_url(order),
      cancel_url: order_url(order)
    )

    order.update(checkout_session_id: session.id)
    redirect_to new_order_payment_path(order)
  end
end
