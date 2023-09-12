class OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def new_index
    @orders = Order.where(user: current_user)
  end


  def show
    @order = Order.find(params[:id])
  end

  def new
    @order = order.new
  end

  def create
    cart = Cart.find(params[:cart_id])
    order = Order.create(cart: cart, amount_cents: cart.total_price, state: 'pending', user: current_user)

    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        price_data: {
          unit_amount: order.amount_cents,
          currency: 'usd',
          product_data: {
            name: "Order #{order.id}"
          },
        },
        quantity: 1
      }],
      mode: 'payment',
      success_url: order_url(order),
      cancel_url: order_url(order)
    )

    order.update(checkout_session_id: session.id)
    redirect_to new_order_payment_path(order)
  end
end
