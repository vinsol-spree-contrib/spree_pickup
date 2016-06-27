Deface::Override.new(
  virtual_path: 'spree/admin/orders/customer_details/_form',
  name: 'add_select_pickup_or_normal_order_backend',
  insert_before: '[data-hook="bill_address_wrapper"]',
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
