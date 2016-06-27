Deface::Override.new(
  virtual_path: 'spree/checkout/_address',
  name: 'add_select_pickup_or_normal_order',
  insert_before: '[data-hook="billing_fieldset_wrapper"]',
  text: '
      <div class= "col-md-12">
        <div class= "col-md-5 text-center h2">
          <span class = "shipping">Shipping Address</span>
        </div>

        <div class= "col-md-2 text-center h2"><span> OR </span></div>

        <div class= "col-md-5 text-center h2">
          <span class="pickup">Pickup Location</span>
        </div>
        <br/>
  '
)
