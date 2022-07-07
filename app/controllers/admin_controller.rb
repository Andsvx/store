class AdminController < ApplicationController
  before_action :check_permission

  def index; end

  def items
    @items = Item.all
  end

  def categories
    @categories = Category.all
  end

  def orders
    @orders = Order.all
  end

  def users
    @users = User.all
  end
end
