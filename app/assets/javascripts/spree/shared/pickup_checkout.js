function PickupCheckout (pickupDiv, shippingDiv) {
  this.pickupDiv = pickupDiv;
  this.shippingDiv = shippingDiv;
}

PickupCheckout.prototype.init = function() {
  var order_use_billing = this.shippingDiv.find('#order_use_billing');
  this.shippingDiv.find('[type=hidden]').not('._destroy_ship').attr('disabled', true)
  order_use_billing.attr('disabled', true);
  this.bindEvent();
};

PickupCheckout.prototype.bindEvent = function() {
  var _this = this;
  $('.pickup').on('click', function(event) {
    _this.toggleShippingAddress(false);
    _this.togglePickupLocation(true);
  });

  $('.shipping').on('click', function(event) {
    _this.toggleShippingAddress(true);
    _this.togglePickupLocation(false);
  });
};

PickupCheckout.prototype.togglePickupLocation = function(val) {
  // val ? this.pickupDiv.removeClass('hide') : this.pickupDiv.addClass('hide');
  // val ? $('#myModal').modal('show') : $('#myModal').modal('hide');
  if(val) {
    this.pickupDiv.removeClass('hide');
    $('#myModal').modal('show');
  } else {
    this.pickupDiv.addClass('hide');
    $('#myModal').modal('hide');
  }
  $('._destroy_ship').val(val)

};

PickupCheckout.prototype.toggleShippingAddress = function(val) {
  var pickupInput = $('.pickup_id');
  if(val) {
   this.pickupVal = pickupInput.val();
   pickupInput.val('')
   this.shippingDiv.removeClass('hide');
   this.shippingDiv.find('input, select').addClass('required').prop( "disabled", false );
  } else {
    this.shippingDiv.addClass('hide');
    this.shippingDiv.find('input, select').not('._destroy_ship').removeClass('required').prop( "disabled", true );
    pickupInput.val(this.pickupVal);
  }
  val ? this.shippingDiv.removeClass('hide') : this.shippingDiv.addClass('hide');
  // val ? this.shippingDiv.removeClass('hide') : this.shippingDiv.addClass('hide');
};
