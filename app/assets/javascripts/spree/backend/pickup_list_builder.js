function PickupListBuilder(pickupLocations) {
  this.pickupLocations = pickupLocations;
}

PickupListBuilder.prototype.init = function() {
  this.initializeList();
};

PickupListBuilder.prototype.initializeList = function() {
  var _this = this;
  var $destination = $('[data-hook=pickup_locations_wrapper]');
  $destination.empty();
  $div = $('<div/>', { clas: 'row' });
  $.each(this.pickupLocations, function(a, b){
    div = _this.buildPickupTemplate(++a , b);
    $div.append(div) ;
  });
  $destination.append($div);
};

PickupListBuilder.prototype.buildPickupTemplate = function(index, pickupObject) {
  var $div = $('<div/>', { class: "address vcard panel-body", data: {id: pickupObject.id} }),
      $fnDiv = $('<div/>', { class: 'fn', text: pickupObject.name }),
      $adrDiv = $('<div/>', { class: 'adr' }),
      $streetAddressDiv = $('<div/>', { class: 'street-address', text: ((pickupObject.address.address1 || '') + ' ' + (pickupObject.address.address2 || ''))} ),
      $localAddressDiv = $('<div/>', { class: 'local' }),
      $localitySpan = $('<span/>', { class: 'locality', text: pickupObject.address.city + ' ' }),
      $regionSpan = $('<span/>', { class: 'region', text: pickupObject.address.state.name + ' ' }),
      $zipcodeSpan = $('<span/>', { class: 'zipcode', text: pickupObject.address.zipcode + ' ' }),
      $countrySpan = $('<span/>', { class: 'country', text: pickupObject.address.country.name }),
      $phoneDiv = $('<div/>', { class: 'tel', text: pickupObject.address.phone }),
      $openDayTimingsDiv = $('<div/>', { class: 'open-day-timings' }),
      $daysSpan = $('<div/>', { class: 'days', text: this.daysDecorator(pickupObject) }),
      $timingSpan = $('<div/>', { class: 'timings', text: this.timeDecorator(pickupObject) }),
      $indexSpan = $('<span/>', {  class: "img-label" }),
      $indexImg = $('<img/>', { src: this.imageUrlBuilder(index), class: 'index' }),
      $dispatchDiv = $('<div/>', { text: 'Dispatch', class: 'btn btn-warning dispatch' });

  $localAddressDiv.append($localitySpan, $regionSpan, $zipcodeSpan, $countrySpan);
  $adrDiv.append($streetAddressDiv, $localAddressDiv);
  $openDayTimingsDiv.append($daysSpan, $timingSpan);
  $indexSpan.append($indexImg);
  $div.append($indexSpan, $fnDiv, $adrDiv, $phoneDiv, $openDayTimingsDiv, $dispatchDiv);
  return $('<div/>', { class: 'col-md-6' }).append($('<div/>', { class: 'panel panel-default pickup-panel' }).append($div));
};

PickupListBuilder.prototype.imageUrlBuilder = function(value) {
  var image_url = "https://images-eu.ssl-images-amazon.com/images/G/31/x-site/cvs/map/location_" + value + "._CB138359918_.gif"
  return image_url;
};

PickupListBuilder.prototype.timeDecorator = function(object) {
  var startTime = new Date(object.start_time);
  var endTime = new Date(object.end_time)
  return(startTime.getHours() + ':' + startTime.getMinutes() + " - " + endTime.getHours() + ':' + endTime.getMinutes() )
};

PickupListBuilder.prototype.daysDecorator = function(object) {
  var days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thur', 'Fri', 'Sat'];
  return object.timings.map(function(data) {
    return(days[data.day_id]);
  }).join(', ');
};
