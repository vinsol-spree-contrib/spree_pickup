# Deface::Override.new(:virtual_path => 'spree/admin/orders/_shipment',
#   :name => 'add_delivered_btn_in_shipment',
#   :insert_after => "strong.stock-location-name",
#   :text => "
#     <% if((shipment.shipped? || shipment.pickup_ready?) and can?(:update, shipment)) %>
#       <%= link_to 'Delivered', 'javascript:;', class: 'deliver pull-right btn btn-success', data: { 'shipment-number' => shipment.number } %>
#       <div class='clearfix'></div>
#     <% end %>
#   ")

