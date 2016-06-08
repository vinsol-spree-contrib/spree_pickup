Deface::Override.new(
  virtual_path: 'spree/shared/_order_details',
  name: 'add_condition_in_order_details',
  replace: '[data-hook="order-ship-address"]',
  text: '<%if order.ship_address.present?%>
          <div class="col-md-3" data-hook="order-ship-address">
            <h4><%= Spree.t(:shipping_address) %> <%= link_to "(#{Spree.t(:edit)})", checkout_state_path(:address) unless order.completed? %></h4>
            <%= render "spree/shared/address", address: order.ship_address %>
          </div>
        <%else%>
          <div class="col-md-3" data-hook="order-ship-address">
            <h4>Pick up Address <%= link_to "(#{Spree.t(:edit)})", checkout_state_path(:address) unless order.completed? %></h4>
            <%debugger%>
            <%= render "spree/shared/address", address: order.pickup_location.address %>
          </div>
        <%end%>
        '
)
