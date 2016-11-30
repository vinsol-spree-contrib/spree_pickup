function PickupCheckout (pickupDiv, shippingDiv) {
  this.pickupDiv = pickupDiv;
  this.shippingDiv = shippingDiv;
  this.pickupIdInput = $('.pickup_id');
  this.destroyShipInput = $('._destroy_ship');
  this.pickupNavLink = $('#pickup_address_link');
  this.shippingNavLink = $('#shipping_address_link');
}

PickupCheckout.prototype.init = function() {
  this.shippingDiv.find('[type=hidden]').not('._destroy_ship').attr('disabled', true)
  this.bindEvent();
};

PickupCheckout.prototype.bindEvent = function() {
  var _this = this;
  this.pickupNavLink.on('click', function(event) {
    _this.toggleShippingAddress(false);
    _this.destroyShipInput.val(true);
    _this.shippingNavLink.parents('li').removeClass('active');
    _this.pickupNavLink.parents('li').addClass('active');
  });

  this.shippingNavLink.on('click', function(event) {
    _this.toggleShippingAddress(true);
    _this.destroyShipInput.val(false);
    _this.pickupNavLink.parents('li').removeClass('active');
    _this.shippingNavLink.parents('li').addClass('active');
  });

  $('body').on('click', ".dispatch", this.setPickupValue.bind(_this));
};

PickupCheckout.prototype.toggleShippingAddress = function(val) {
  if(val) {
   this.pickupVal = this.pickupIdInput.val();
   this.pickupIdInput.val('')
   this.shippingDiv.find('input, select').addClass('required').prop( "disabled", false );
   this.shippingDiv.find('#order_use_billing').attr('disabled', false);
  } else {
    this.shippingDiv.find('input, select').not('._destroy_ship').removeClass('required').prop( "disabled", true );
    this.shippingDiv.find('#order_use_billing').attr('disabled', true);
    this.pickupIdInput.val(this.pickupVal);
  }
};

PickupCheckout.prototype.setPickupValue = function(event) {
  var selectedDiv = $(event.currentTarget).parents('.address.vcard');
  this.pickupIdInput.val(selectedDiv.data('id'));
};
