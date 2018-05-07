Deface::Override.new(
  virtual_path: 'spree/admin/orders/edit',
  name: 'add partial to orders edit',
  replace: %Q(erb[loud]:contains("render 'add_product' if @order.shipment_state != 'shipped' && can?(:update, @order)")),
  text: "<%= render partial: 'add_product' if !['shipped', 'ready', 'ready_for_pickup', 'delivered'].include?(@order.shipment_state) && can?(:update, @order) %>"
)

Deface::Override.new(
  virtual_path: 'spree/admin/orders/edit',
  name: 'add javascript_tag to head',
  insert_after: '[data-hook="admin_order_edit_form"]',
  text: "<% content_for :head do %>
    <%= javascript_tag 'var expand_variants = true;' %>
  <% end %>"
)