Deface::Override.new(
  virtual_path: 'spree/checkout/_address',
  name: 'add_destroy_field_for_ship_address',
  insert_after: '[data-hook="use_billing"]',
  text: '<%=ship_form.hidden_field :_destroy, class: "_destroy_ship"%>'
)
