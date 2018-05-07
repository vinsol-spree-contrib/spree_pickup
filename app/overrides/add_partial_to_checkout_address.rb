Deface::Override.new(
  virtual_path: 'spree/checkout/_address',
  name: 'add_partial_to_checkout_address',
  replace_contents: '.row',
  partial: 'spree/checkout/address_deface'
)
