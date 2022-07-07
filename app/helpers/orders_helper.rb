module OrdersHelper
  def link_to_order(order)
    link_to "##{order.id}", order_path(order)
  end
end
