Deface::Override.new(
  virtual_path: 'spree/checkout/_address',
  name: 'add_javascript_address_form',
  insert_after: 'div[data-hook="buttons"]',
  text: " <%=javascript_include_tag 'spree/frontend/pickup_address_form'%> "
)
