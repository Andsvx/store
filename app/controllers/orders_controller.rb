class OrdersController < ApplicationController
  before_action :check_authorization
  before_action :find_order, only: %i[show]
  before_action :find_cart_positions, only: %i[new create]

  def index
    @orders = Order.where(user_id: current_user.id)
  end

  def show; end

  def new
    @order = Order.new
  end

  def create
    @order = Order.where(user_id: current_user.id).create(order_params)

    if @order.errors.empty?
      @cart_positions.each do |position|
        OrderPosition.create!(order_id: @order.id, item_id: position.item_id, quantity: position.quantity)
        position.destroy!
      end

      redirect_to order_path(@order)
    else
      render 'new'
    end
  end

  private

  def order_params
    params.require(:order).permit(:address, :phone_number)
  end

  def find_order
    @order = Order.find_by(id: params[:id])
    render_404 unless @order
  end

  def find_cart_positions
    @cart_positions = current_user.cart.cart_positions

    return if @cart_positions.present?

    flash[:alert] = t(:cart_is_empty, scope: %i[orders messages])
    redirect_to cart_path
  end
end
