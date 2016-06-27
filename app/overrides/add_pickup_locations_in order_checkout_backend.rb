Deface::Override.new(
  virtual_path: 'spree/admin/orders/customer_details/_form',
  name: 'add_pickup_locations_in order_checkout_backend',
  insert_after: '[data-hook="bill_address_wrapper"]',
  partial: 'spree/admin/orders/customer_details/pickup_location'
)
