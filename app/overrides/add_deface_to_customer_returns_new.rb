Deface::Override.new(
  virtual_path: 'spree/admin/customer_returns/new',
  name: 'remove span from customer_returns',
  remove: 'span.required'
)

Deface::Override.new(
  virtual_path: 'spree/admin/customer_returns/new',
  name: 'change id in customer_returns',
  replace: 'erb[loud]:contains(" f.error_message_on :stock_location ")',
  text: ' <%= f.error_message_on :stock_location_id %> '
)