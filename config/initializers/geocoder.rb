Geocoder.configure(
  timeout: 5,
  lookup: :google,
  ip_lookup: :freegeoip,
  language: :en,
  use_https: true,
  units: :km,
  distances: :linear  # :linear or :spherical
)
