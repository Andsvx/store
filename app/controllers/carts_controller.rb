class CartsController < ApplicationController
  before_action :check_authorization

  def show
    @cart_positions = current_user.cart.cart_positions
  end

  def add_to_cart
    if (cart_position = find_cart_position)
      cart_position.increment!(:quantity)
    else
      CartPosition.create(cart_id: current_user.cart.id, item_id: params['id'], quantity: 1)
    end

    redirect_to cart_path
  end

  def remove_from_cart
    cart_position = find_cart_position

    if cart_position.quantity > 1
      cart_position.decrement!(:quantity)
    else
      cart_position.destroy!
    end

    redirect_to cart_path
  end

  private

  def find_cart_position
    CartPosition.find_by(cart_id: current_user.cart.id, item_id: params['id'])
  end
end
