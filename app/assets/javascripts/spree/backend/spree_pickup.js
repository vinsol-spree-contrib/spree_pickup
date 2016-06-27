// Placeholder manifest file.
// the installer will append this file to the app vendored assets here: vendor/assets/javascripts/spree/backend/all.js'
//= require 'spree/backend/shipment_decorator.js'

  var update_states = function (region, done) {
  "use strict";
  var country = $("span#" + region + "country-select .select22").val();
  var state_select = $("span#" + region + "state select.select22");
  var state_input = $("span#" + region + "state input.state_name");
  $.get(Spree.routes.states_search + "?country_id=" + country, function (data) {
    var states = data.states;
    if (states.length > 0) {
      state_select.html("");
      var states_with_blank = [{
        name: "",
        id: ""
      }].concat(states);
      $.each(states_with_blank, function (pos, state) {
        var opt = $(document.createElement("option"))
          .prop("value", state.id)
          .html(state.name);
        state_select.append(opt);
      });
      state_select.prop("disabled", false).show();
      // state_select.select2();
      state_input.hide().prop("disabled", true);

    } else {
      // state_input.prop("disabled", false).show();
      state_select.hide();
    }

    if(done) done();
  });
};
