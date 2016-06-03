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
      _this.display(data);
      _this.initializeMap(data);
    });
  });
};

PickupLocationGetter.prototype.buildPath = function(s_id, c_id) {
  path = window.location.origin + this.path + '?s_id=' + s_id + '&c_id=' + c_id
  return path;
};

PickupLocationGetter.prototype.initializeMap = function(data) {
  debugger
  var mI = new MapInitializer(this.stateSelect.find(':selected').text() + ', ' + this.countrySelect.find(':selected').text());
  mI.init();
  mI.setMarker(data);
};

PickupLocationGetter.prototype.display = function(data) {
  var $destination = $('[data-hook=pickup_locations_wrapper]');
  $destination.empty();
  $div = $('<div/>');
  $.each(data, function(a, b){
    var text = ++a + ')' + b.name + "    " + b.state.name + ", " +  b.country.name;
    $div.append( $('<div/>', {text: text, class: 'col-md-12'}) );
  });
  $destination.append($div);
};


