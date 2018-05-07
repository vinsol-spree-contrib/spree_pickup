Deface::Override.new(
  virtual_path: 'spree/admin/orders/_shipment',
  name: 'replace text in orders shipment',
  replace: 'erb[silent]:contains("unless shipment.shipped?")',
  text: '<% unless shipment.finalized? %>'
)
