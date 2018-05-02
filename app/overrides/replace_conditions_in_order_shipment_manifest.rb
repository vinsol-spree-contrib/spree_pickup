Deface::Override.new(
  virtual_path: 'spree/admin/orders/_shipment_manifest',
  name: 'change unless condition in shipping manifest',
  replace: 'erb[silent]:contains("unless shipment.shipped?")',
  text: '<% unless shipment.finalized? %>'
)

Deface::Override.new(
  virtual_path: 'spree/admin/orders/_shipment_manifest',
  name: 'change if condition in shipping manifest',
  replace: 'erb[silent]:contains("if((!shipment.shipped?) && can?(:update, item.line_item))")',
  text: '<% if((!shipment.finalized?) && can?(:update, item.line_item)) %>'
)