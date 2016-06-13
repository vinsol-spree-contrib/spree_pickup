# Deface::Override.new(:virtual_path => 'spree/admin/orders/_shipment',
#   :name => 'add_pickup_ship_btn_in_shipment',
#   :insert_after => "strong.stock-location-name",
#   :text => "
#     <% if(@order.pickup? && shipment.ready? && can?(:update, shipment)) %>
#       <%= link_to 'Ship to Pickup Location', 'javascript:;', class: 'pickup_ship pull-right btn btn-success', data: { 'shipment-number' => shipment.number } %>
#       <div class='clearfix'></div>
#     <% end %>
#   ")

