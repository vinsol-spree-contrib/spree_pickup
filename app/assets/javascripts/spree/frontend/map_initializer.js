function MapInitializer(default_country) {
  this.default_country = default_country;
  this.geocoder = new google.maps.Geocoder();
}

MapInitializer.prototype.init = function() {
   this.map = new google.maps.Map(document.getElementById('map'), {
                center: {lat: 44.540, lng: -78.546},
                zoom: 11
              });
   this.setCenter();
};

MapInitializer.prototype.setMarker = function(collection) {
  var _this = this;
  $.each(collection, function(index, value) {
    marker = _this.addMarker(index, value);
    _this.addInfoWindow(marker, value.name);
  })
};

MapInitializer.prototype.addInfoWindow = function(marker, info) {
  var _this = this;
  var infowindow = new google.maps.InfoWindow();
  google.maps.event.addListener(marker, 'click', function() {
    infowindow.setContent(info);
    infowindow.open(_this.map, marker);
  });
};

MapInitializer.prototype.addMarker = function(index, object) {
  var _this = this;
  var marker = new google.maps.Marker({
    position: {lat: object.latitude, lng: object.longitude},
    icon: _this.imageUrlBuilder(++index),
    map: this.map
  });
  return marker;
};

MapInitializer.prototype.imageUrlBuilder = function(value) {
  var image_url = "https://images-eu.ssl-images-amazon.com/images/G/31/x-site/cvs/map/location_" + value + "._CB138359918_.gif"
  return image_url;
};

MapInitializer.prototype.setCenter = function() {
  var _this = this;
  if(_this.default_country) {
    this.geocoder.geocode( { 'address': _this.default_country}, function(results, status) {
      if (status == google.maps.GeocoderStatus.OK) {
        _this.map.setCenter(results[0].geometry.location);
      }
    });
  } else {
    _this.setToCurrentLocation();
  }
};

MapInitializer.prototype.setToCurrentLocation =  function() {
  var _this = this;
  navigator.geolocation.getCurrentPosition(function(position) {
    _this.map.setCenter({lat: position.coords.latitude, lng: position.coords.longitude });
  }, function(error) {
    console.log(error.message)
  });
}
