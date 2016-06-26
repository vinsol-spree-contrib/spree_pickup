Deface::Override.new(
  virtual_path: 'spree/checkout/_address',
  name: 'modify_ship_address_checkout',
  replace: '[data-hook="shipping_fieldset_wrapper"]',
  text: '<%kls1 = @order.ship_address.try(:persisted?) ? "col-md-6" : "col-md-6 hide"%>
        <div class=<%=kls1%> data-hook="shipping_fieldset_wrapper">
          <div class="panel panel-default" id="shipping" data-hook>
            <%= form.fields_for :ship_address do |ship_form| %>
              <div class="panel-heading">
                <h3 class="panel-title"><%= Spree.t(:shipping_address) %></h3>
              </div>
              <div class="panel-body">
                <p class="field checkbox" data-hook="use_billing">
                  <%= label_tag :order_use_billing, :id => "use_billing" do %>
                    <%= check_box_tag "order[use_billing]", "1", @order.shipping_eq_billing_address? %>
                    <%= Spree.t(:use_billing_address) %>
                  <% end %>
                </p>
                <%=ship_form.hidden_field :_destroy, class: "_destroy_ship"%>
                <%= render :partial => "spree/address/form", :locals => { :form => ship_form, :address_type => "shipping", :address => @order.ship_address } %>
              </div>
            <% end %>
          </div>
        </div>
        '
)
