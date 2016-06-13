# Deface::Override.new(:virtual_path => 'spree/admin/orders/_shipment',
#   :name => 'add_pickup_ready_btn_in_shipment',
#   :insert_before => "strong.stock-location-name",
#   :text => "
#     <% if(@order.pickup? && (shipment.pickup_shipped? || shipment.ready?) && can?(:update, shipment)) %>
#       <%= link_to 'Pick up Ready', 'javascript:;', class: 'pickup_ready pull-right btn btn-success', data: { 'shipment-number' => shipment.number } %>
#       <div class='clearfix'></div>
#     <% end %>
#   ")

