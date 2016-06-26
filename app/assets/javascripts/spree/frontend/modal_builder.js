function ModalBuilder(pickupLocations) {
  this.pickupLocations = pickupLocations;
}

ModalBuilder.prototype.init = function() {
  this.bindEvent();
  this.initializeModal();
};

ModalBuilder.prototype.bindEvent = function() {
  var _this = this;
  $('body').on('click', ".dispatch", _this.setPickupValue.bind(this));
};

ModalBuilder.prototype.setPickupValue = function(event) {
  var selectedDiv = $(event.currentTarget).parents('.pick-up-div').clone(true);
  var pickupObject = selectedDiv.data('object');
  $('.pickup_id').val(pickupObject.id);
  var pickupContentDiv = $('[data-hook="pickup_fieldset_wrapper"]').find('.address');
  pickupContentDiv.removeClass('hide');
  pickupContentDiv.append(selectedDiv);
  pickupContentDiv.find('.dispatch, .index, .img-line').remove();
  $('#myModal').modal('hide')
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
  var $div = $('[data-hook="pickup_fieldset_wrapper"]').find('.address').clone();
  var locationName = pickupObject.name
  var fullName = pickupObject.address.firstname + " " + pickupObject.address.lastname;
  var address = pickupObject.address;
  var streetAddress = address.address1 + "\n" + address.address2

  $div.find('.fn').text(fullName);
  $div.find('.adr .street-address .street-address-line').text(streetAddress);
  $div.find('.adr .local .locality').text(address.city);
  $div.find('.adr .local .region').text(address.state.name);
  $div.find('.adr .local .postal-code').text(address.zipcode);
  $div.find('.adr .local .country-name').text(address.country.name);
  $div.addClass('col-md-12').addClass('pick-up-div').attr('data-id', pickupObject.id).data('object', pickupObject)

  var indexDiv = $('<div/>'), dispatchDiv = $('<div/>'), timingDiv = $('<div/>'), daysDiv = $('<div/>');

  indexDiv.append($('<img/>', {src: this.imageUrlBuilder(index), class: 'index'}));
  daysDiv.text(this.daysDecorator(pickupObject));
  timingDiv.text(this.timeDecorator(pickupObject));
  dispatchDiv.text('Dispatch to this Address').addClass("btn btn-warning dispatch");

  $div.append(timingDiv).append(daysDiv).append(dispatchDiv);
  $div.append('<div class="col-md-12 img-line"><img src="https://images-eu.ssl-images-amazon.com/images/G/31/x-locale/common/icons/green-pixel._CB138348737_.gif" vspace="6" width="100%" align="top" height="1" border="0"></div>')
  $div.prepend($('<div/>', {text: locationName}));
  $div.prepend(indexDiv);
  return $div;
};

ModalBuilder.prototype.imageUrlBuilder = function(value) {
  var image_url = "https://images-eu.ssl-images-amazon.com/images/G/31/x-site/cvs/map/location_" + value + "._CB138359918_.gif"
  return image_url;
};

ModalBuilder.prototype.timeDecorator = function(object) {
  var startTime = new Date(object.start_time);
  var endTime = new Date(object.end_time)
  return(startTime.getHours() + ':' + startTime.getMinutes() + " - " + endTime.getHours() + ':' + endTime.getMinutes() )
};

ModalBuilder.prototype.daysDecorator = function(object) {
  var days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thur', 'Fri', 'Sat'];
  return object.timings.map(function(data) {
    return(days[data.day_id]);
  }).join(', ');
};
