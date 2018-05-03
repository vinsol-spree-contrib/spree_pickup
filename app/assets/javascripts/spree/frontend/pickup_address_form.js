function CheckoutAddressManager(options) {
  this.$shippingForm = options.$shippingForm;
  this.$fields = options.$fields;
}

CheckoutAddressManager.prototype.initialize = function() {
  this.$shippingForm.find(this.$fields).removeAttr('required');
}

$(document).ready(function() {
  var options = {
    $shippingForm: $('[data-hook="shipping_inner"]'),
    $fields: '.form-control'
  },
     checkoutAddressManager = new CheckoutAddressManager(options);

  checkoutAddressManager.initialize();
});