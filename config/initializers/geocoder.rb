require 'geocoder'

Geocoder.configure(
  # geocoding service
  lookup: :google,

  # geocoding service request timeout (in seconds)
  timeout: 3,

  # default units
  units: :km,

  #api_key
  key: Rails.application.secrets.google_geocode_api_key,

  #use_https
  use_https: true
)
