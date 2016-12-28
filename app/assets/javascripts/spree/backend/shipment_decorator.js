function ShipmentDecorator () {}

ShipmentDecorator.prototype.bindEvent = function() {
  var _this = this;
  $('[data-hook=admin_shipment_form] a.deliver').on('click', _this.sendDeliverRequest.bind(this));
  $('[data-hook=admin_shipment_form] a.pickup_ship').on('click', _this.sendPickupShipRequest.bind(this));
  $('[data-hook=admin_shipment_form] a.pickup_ready').on('click', _this.sendPickupReadyRequest.bind(this));
};

ShipmentDecorator.prototype.sendDeliverRequest = function (event) {
  var link = $(event.currentTarget);
  var url = this.buildUrl(link, 'deliver');
  this.sendRequest(url);
};


ShipmentDecorator.prototype.sendPickupShipRequest = function (event) {
  var link = $(event.currentTarget);
  var url = this.buildUrl(link, 'ship_for_pickup');
  this.sendRequest(url);
};

ShipmentDecorator.prototype.sendPickupReadyRequest = function (event) {
  var link = $(event.currentTarget);
  var url = this.buildUrl(link, 'ready_for_pickup');
  this.sendRequest(url);
};

ShipmentDecorator.prototype.sendRequest = function(url) {
  $.ajax({
    type: 'PUT',
    url: url,
    data: {
      token: Spree.api_key
    }
  }).done(function () {
    window.location.reload();
  }).error(function (msg) {
    console.log(msg);
  });
};

ShipmentDecorator.prototype.buildUrl = function(link, methodName) {
  var shipment_number = link.data('shipment-number');
  var url = Spree.url(Spree.routes.shipments_api + '/' + shipment_number + '/' + methodName + '.json');
  return url;
};

$(function() {
  var sD = new ShipmentDecorator();
  sD.bindEvent();
})
