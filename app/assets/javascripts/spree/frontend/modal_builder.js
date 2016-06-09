function ModalBuilder(pickupLocations) {
  this.pickupLocations = pickupLocations;
}

ModalBuilder.prototype.init = function() {
  this.bindEvent();
  this.initializeModal();
};

ModalBuilder.prototype.bindEvent = function() {
  var _this = this;
  $('body').on('click', ".btn-warning", _this.setPickupValue.bind(this));
};

ModalBuilder.prototype.setPickupValue = function(event) {
  debugger
  var pickupObject = $(event.currentTarget).parents('.pick-up-div').data('object')
  $('.pickup_id').val(pickupObject.id);
  this.createSelectedLocationContent(pickupObject);
};

ModalBuilder.prototype.createSelectedLocationContent = function(pickupObject) {
  content = pickupObject.address.first_name + " " + pickupObject.address.last_name + " "  + this.addressBuilder(pickupObject.address);
  var pickupContentDiv = $('[data-hook="pickup-content"]');
  pickupContentDiv.append($('<div/>', {text: content}));
  $('[data-hook="pickup_fieldset_wrapper"]').removeClass('hide');
  $('#myModal').modal('hide')
  debugger
};

ModalBuilder.prototype.initializeModal = function() {
  var _this = this;
  var $destination = $('[data-hook=pickup_locations_wrapper]');
  $destination.empty();
  $div = $('<div/>');
  $.each(this.pickupLocations, function(a, b){
    div = _this.buildPickupDiv(++a , b);
    $div.append(div) ;
  });
  $destination.append($div);
};

ModalBuilder.prototype.buildPickupDiv = function(index, pickupObject) {
  var $div = $('<div/>', {class: 'col-md-12 pick-up-div', 'data-id' : pickupObject.id}).data('object', pickupObject);
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

ModalBuilder.prototype.imageUrlBuilder = function(value) {
  var image_url = "https://images-eu.ssl-images-amazon.com/images/G/31/x-site/cvs/map/location_" + value + "._CB138359918_.gif"
  return image_url;
};

ModalBuilder.prototype.addressBuilder = function(address) {
  a =  address.address1 + " " + address.address2 + " " + address.city + " " + address.state.name +" " +  address.zipcode + " " + address.country.name
  return a;
};
