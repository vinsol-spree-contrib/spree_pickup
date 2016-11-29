function SpreeStatesFetcher(stateSelect, countrySelect) {
  this.stateSelect = stateSelect;
  this.countrySelect = countrySelect;
}

SpreeStatesFetcher.prototype.init = function() {
  this.bindEvent();
}

SpreeStatesFetcher.prototype.bindEvent = function() {
  var _this = this;
  this.countrySelect.on('change', _this.fetch.bind(_this));
}

SpreeStatesFetcher.prototype.fetch = function() {
  var country_id = this.countrySelect.val(), _this= this;
  var state_input = $("span#state input.state_name");
  $.get(Spree.routes.states_search + "?country_id=" + country_id, function (data) {
    var states = data.states;
    if (states.length > 0) {
      _this.stateSelect.html("");
      var states_with_blank = [{
        name: "",
        id: ""
      }].concat(states);
      $.each(states_with_blank, function (pos, state) {
        var opt = $(document.createElement("option"))
          .prop("value", state.id)
          .html(state.name);
        _this.stateSelect.append(opt);
      });
      _this.stateSelect.prop("disabled", false).show();
      // state_select.select2();
      state_input.hide().prop("disabled", true);

    } else {
      // state_input.prop("disabled", false).show();
      _this.stateSelect.hide();
    }
  });
}
