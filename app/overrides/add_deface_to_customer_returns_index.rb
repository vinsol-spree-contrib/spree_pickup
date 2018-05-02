Deface::Override.new(
  virtual_path: 'spree/admin/customer_returns/index',
  name: 'add_variable_to_customer_returns',
  insert_before: 'erb[silent]:contains("content_for :page_actions")',
  text: '<% any_shipment_finalized  = @order.shipments.any? { |shipment| shipment.finalized? } %>'
)

Deface::Override.new(
  virtual_path: 'spree/admin/customer_returns/index',
  name: 'change_condition_in_customer_returns',
  replace: 'erb[silent]:contains(" if @order.shipments.any?(&:shipped?) && can?(:create, Spree::CustomerReturn) ")',
  text: '<% if any_shipment_finalized && can?(:create, Spree::CustomerReturn) %>'
)

Deface::Override.new(
  virtual_path: 'spree/admin/customer_returns/index',
  name: 'change_shipping_condition_in_customer_returns',
  replace: 'erb[silent]:contains(" if @order.shipments.any?(&:shipped?) ")',
  text: '<% if any_shipment_finalized %>'
)