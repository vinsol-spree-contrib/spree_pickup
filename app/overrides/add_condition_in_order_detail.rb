Deface::Override.new(
  virtual_path: 'spree/shared/_order_details',
  name: 'add_condition_in_order_details',
  replace: '[data-hook="order-ship-address"]',
  text: ' <% title = order.pickup? ? Spree.t(:pickup_address) : Spree.t(:shipping_address) %>
          <div class="col-md-3" data-hook="order-ship-address">
            <h4><%= title %> <%= link_to "(#{Spree.t(:edit)})", checkout_state_path(:address) unless order.completed? %></h4>
            <%= render "spree/shared/address", address: order.ship_address %>
          </div>
        '
)
