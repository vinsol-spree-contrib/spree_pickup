function PickupCheckout (pickupDiv, shippingDiv) {
  this.pickupDiv = pickupDiv;
  this.shippingDiv = shippingDiv;
}

PickupCheckout.prototype.init = function() {
  this.bindEvent();
};

PickupCheckout.prototype.bindEvent = function() {
  var _this = this;
  $('.pickup-checkbox').on('change', function(event) {
    var val = $(event.currentTarget).is(':checked');
    _this.toggleShippingAddress(val);
    _this.togglePickupLocation(val);
  });
};

PickupCheckout.prototype.togglePickupLocation = function(val) {
  val ? this.pickupDiv.show() : this.pickupDiv.hide();
};

PickupCheckout.prototype.toggleShippingAddress = function(val) {
  val ? this.shippingDiv.hide() : this.shippingDiv.show();
};
