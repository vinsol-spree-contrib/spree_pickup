Deface::Override.new(
  virtual_path: 'spree/admin/orders/customer_details/_form',
  name: 'add_destroy_field_for_ship_address_admin_end',
  insert_after: '[data-hook="use_billing"]',
  text: '<%=sa_form.hidden_field :_destroy, class: "_destroy_ship"%>'
)
