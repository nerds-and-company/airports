defmodule Airports.Airport do
  defstruct [
    :ident,
    :type,
    :name,
    :latitude,
    :longitude,
    :elevation_ft,
    :continent,
    :iso_country,
    :iso_region,
    :municipality,
    :scheduled_service,
    :gps_code,
    :iata_code,
    :local_code,
    :home_link,
    :wikipedia_link,
    :keywords
  ]
end
