function PickupLocationGetter(path) {
  this.path = path
  this.stateSelect = $('#state .select22');
  this.countrySelect = $('#country .select22');
}


PickupLocationGetter.prototype.init = function() {
  this.bindEvent();
};

PickupLocationGetter.prototype.bindEvent = function() {
  var _this = this;
  this.stateSelect.on('change', function(event) {
    var s_id = _this.stateSelect.val();
    var c_id = _this.countrySelect.val();
    path = _this.buildPath(s_id, c_id);
    $.get(path, function(data, status) {
      _this.initializeModal(data);
      _this.initializeMap(data);
    });
  });

};

PickupLocationGetter.prototype.buildPath = function(s_id, c_id) {
  path = window.location.origin + this.path + '?s_id=' + s_id + '&c_id=' + c_id
  return path;
};

PickupLocationGetter.prototype.initializeMap = function(data) {
  var mI = new MapInitializer(this.stateSelect.find(':selected').text() + ', ' + this.countrySelect.find(':selected').text());
  mI.init();
  mI.setMarker(data);
};

PickupLocationGetter.prototype.initializeModal = function(data) {
  var _this = this;
  var $destination = $('[data-hook=pickup_locations_wrapper]');
  $destination.empty();
  $div = $('<div/>');
  $.each(data, function(a, b){
    div = _this.buildPickupLocationDiv(++a , b);
    $div.append(div) ;
  });
  $destination.append($div);
};


PickupLocationGetter.prototype.buildPickupLocationDiv = function(index, pickupObject) {
  var $div = $('<div/>', {class: 'col-md-12', 'data-id' : pickupObject.id});
  var indexDiv = $('<div/>');
  var dispatchDiv = $('<div/>');
  var nameDiv = $('<div/>');
  var addressDiv = $('<div/>');
  var timingDiv = $('<div/>');

  indexDiv.append($('<img/>', {src: this.imageUrlBuilder(index)}));
  nameDiv.text(pickupObject.address.first_name + " " + pickupObject.address.last_name)
  addressDiv.text(this.addressBuilder(pickupObject.address));
  timingDiv.text(pickupObject.function_details);
  dispatchDiv.text('Dispatch to this Address').addClass("btn btn-warning");
  $div.append(indexDiv).append(nameDiv).append(addressDiv).append(timingDiv).append(dispatchDiv)
  $div.append('<div class="col-md-12"><img src="https://images-eu.ssl-images-amazon.com/images/G/31/x-locale/common/icons/green-pixel._CB138348737_.gif" vspace="6" width="100%" align="top" height="1" border="0"></div>')
  return $div;
};


PickupLocationGetter.prototype.imageUrlBuilder = function(value) {
  var image_url = "https://images-eu.ssl-images-amazon.com/images/G/31/x-site/cvs/map/location_" + value + "._CB138359918_.gif"
  return image_url;
};


PickupLocationGetter.prototype.addressBuilder = function(address) {
  a =  address.address1 + " " + address.address2 + " " + address.city + " " + address.state.name +" " +  address.zipcode + " " + address.country.name
  return a;
};

