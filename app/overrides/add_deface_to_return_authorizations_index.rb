Deface::Override.new(
  virtual_path: 'spree/admin/return_authorizations/index',
  name: 'add variable to return_authorizations',
  insert_after: %Q(erb[loud]:contains(" render partial: 'spree/admin/shared/order_tabs', locals: { current: :return_authorizations } ")),
  text: " <% any_shipment_finalized  = @order.shipments.any? { |shipment| shipment.finalized? } %> "
)

Deface::Override.new(
  virtual_path: 'spree/admin/return_authorizations/index',
  name: 'change initial shipping conditions in return_authorizations',
  replace: "erb[silent]:contains('if @order.shipments.any?(&:shipped?) && can?(:create, Spree::ReturnAuthorization)')",
  text: "<% if any_shipment_finalized && can?(:create, Spree::ReturnAuthorization) %>"
)

Deface::Override.new(
  virtual_path: 'spree/admin/return_authorizations/index',
  name: 'change shipping conditions in return_authorizations',
  replace: "erb[silent]:contains('if @order.shipments.any?(&:shipped?) && @order.return_authorizations.any?')",
  closing_selector: 'erb[silent]:contains(" end ")',
  partial: 'spree/admin/return_authorizations/conditions'
)
