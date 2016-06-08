function PickupCheckout (pickupDiv, shippingDiv) {
  this.pickupDiv = pickupDiv;
  this.shippingDiv = shippingDiv;
}

PickupCheckout.prototype.init = function() {
  var order_use_billing = this.shippingDiv.find('#order_use_billing');
  order_use_billing.attr('checked', false);
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
  // $('.pickup-checkbox').on('change', function(event) {
  //   var val = $(event.currentTarget).is(':checked');
  //   _this.toggleShippingAddress(val);
  //   _this.togglePickupLocation(val);
  // });
};

PickupCheckout.prototype.togglePickupLocation = function(val) {
  // val ? this.pickupDiv.removeClass('hide') : this.pickupDiv.addClass('hide');
  val ? $('#myModal').modal('show') : $('#myModal').modal('hide');
};

PickupCheckout.prototype.toggleShippingAddress = function(val) {
  if(val) {
   this.shippingDiv.removeClass('hide');
   $('[data-hook="shipping_fieldset_wrapper"]').find('input').addClass('required').prop( "disabled", false );
  } else {
    this.shippingDiv.addClass('hide');
   $('[data-hook="shipping_fieldset_wrapper"]').find('.required').removeClass('required').prop( "disabled", true );
  }
  val ? this.shippingDiv.removeClass('hide') : this.shippingDiv.addClass('hide');
  // val ? this.shippingDiv.removeClass('hide') : this.shippingDiv.addClass('hide');
};
