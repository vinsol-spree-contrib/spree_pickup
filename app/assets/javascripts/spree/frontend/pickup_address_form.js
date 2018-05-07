function PickupAddressForm(options) {
  this.$shippingForm = options.$shippingForm;
  this.$fields = options.$fields;
}

PickupAddressForm.prototype.initialize = function() {
  this.$shippingForm.find(this.$fields).removeAttr('required');
}

$(document).ready(function() {
  var options = {
    $shippingForm: $('[data-hook="shipping_inner"]'),
    $fields: '.form-control'
  },
     pickupAddressForm = new PickupAddressForm(options);

  pickupAddressForm.initialize();
});