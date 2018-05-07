Deface::Override.new(
  virtual_path: 'spree/address/_form',
  name: 'add_class_to_address_form',
  add_to_attributes: 'p[class="form-group"]',
  attributes: { class: 'col-md-6' }
)
