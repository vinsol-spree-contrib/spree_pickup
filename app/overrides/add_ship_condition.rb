Deface::Override.new(
  virtual_path: 'spree/admin/orders/_shipment',
  name: 'add_ship_condition',
  replace: '[data-hook="stock-location"]',
  text: '
  <div class="panel-heading stock-location no-borderb" data-hook="stock-location">
    <h1 class="panel-title">
      <span class="shipment-number"><%= shipment.number %></span>
      -
      <span class="shipment-state"><%= Spree.t("shipment_states.#{shipment.state}") %></span>
      <%= Spree.t(:package_from) %>
      <strong class="stock-location-name" data-hook="stock-location-name">\'<%= shipment.stock_location.name %>\'</strong>
      <% if !@order.pickup? && shipment.ready? and can? :update, shipment %>
        <%= link_to Spree.t(:ship), "javascript:;", class: "ship pull-right btn-sm btn btn-success", data: { "shipment-number"=> shipment.number } %>
        <div class="clearfix"></div>
      <% end %>

      <% if((shipment.shipped? || shipment.ready_for_pickup?) && shipment.inventory_units.where.not(state: "returned").any? and can?(:update, shipment)) %>
        <%= link_to "Deliver", "javascript:;", class: "deliver pull-right btn btn-sm btn-success", data: { "shipment-number"=> shipment.number } %>
        <div class="clearfix"></div>
      <% end %>

      <% if(@order.pickup? && (shipment.shipped_for_pickup? || shipment.ready?) && can?(:update, shipment)) %>
        <%= link_to "Pick up Ready", "javascript:;", class: "pickup_ready pull-right btn-sm btn btn-success lm-5", data: { "shipment-number"=> shipment.number } %>
      <% end %>

      <% if(@order.pickup? && shipment.ready? && can?(:update, shipment)) %>
        <%= link_to "Shipped to Pickup Location", "javascript:;", class: "pickup_ship btn-sm pull-right btn btn-success", data: { "shipment-number"=> shipment.number } %>
      <% end %>
      <br/><br/>

    </h1>
  </div>
'
)
