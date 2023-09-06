class CartsController < ApplicationController
  before_action :set_product, only: %i[new create]

  def index
    @carts = Cart.all
  end

  def new
    @cart = Cart.new
  end

  def create
    @cart = Cart.new(cart_params)
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
  end

  def edit
    @cart = Cart.find(params[:id])
  end

  def update
    @cart = Cart.find(params[:id])
    @cart.update(cart_params)
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
