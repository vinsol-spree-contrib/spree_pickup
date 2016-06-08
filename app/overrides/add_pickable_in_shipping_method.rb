Deface::Override.new(
  virtual_path: 'spree/admin/shipping_methods/_form',
  name: 'add_pickupable_in_shipping_method',
  insert_after: '[data-hook="admin_shipping_method_form_calculator_fields"]',
  text: '<div class="col-md-6">
          <div class="panel panel-default">
            <div class="panel-heading">
              <h1 class="panel-title">
                Pickupable
              </h1>
            </div>

            <div class="panel-body">
              <%= f.check_box :pickupable %>
              <%= f.label :pickupable%>
            </div>
          </div>
        </div>
        '
)
