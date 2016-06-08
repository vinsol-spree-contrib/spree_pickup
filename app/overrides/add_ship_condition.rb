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
      <% if @order.ship_address_id.present? && shipment.ready? and can? :update, shipment %>
        <%= link_to Spree.t(:ship), "javascript:;", class: "ship pull-right btn btn-success", data: { "shipment-number" => shipment.number } %>
        <div class="clearfix"></div>
      <% end %>
    </h1>
  </div>
'
)
