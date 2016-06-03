Deface::Override.new(
  virtual_path: 'spree/checkout/_address',
  name: 'add_pickup_locations_in_checkout',
  insert_after: '[data-hook="billing_fieldset_wrapper"]',
  partial: 'spree/checkout/pickup_location'
)
