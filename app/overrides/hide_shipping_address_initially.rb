Deface::Override.new(
  virtual_path: 'spree/checkout/_address',
  name: 'hide_shipping_address_initially',
  set_attributes: '[data-hook="shipping_fieldset_wrapper"]',
  attributes: {class: 'hide col-md-6'}
)
