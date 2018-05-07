Deface::Override.new(
  virtual_path: 'spree/admin/orders/customer_details/_form',
  name: 'add_partial_to_customer_details_new',
  replace_contents: 'div:not([data-hook])[class="row"]',
  partial: 'spree/admin/orders/customer_details/address'
)