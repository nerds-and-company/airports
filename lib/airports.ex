defmodule Airports do
  data_file = Path.join([__DIR__,"../priv", "airports.dat"])
  @airports File.stream!(data_file, [], :line) |> CSV.decode |> Stream.map(fn line ->
    [
      _,
      ident,
      type,
      name,
      latitude,
      longitude,
      elevation_ft,
      continent,
      iso_country,
      iso_region,
      municipality,
      scheduled_service,
      gps_code,
      iata_code,
      local_code,
      home_link,
      wikipedia_link,
      keywords
    ] = line

    %Airports.Airport{
      ident: ident,
      type: type,
      name: name,
      latitude: latitude,
      longitude: longitude,
      elevation_ft: elevation_ft,
      continent: continent,
      iso_country: iso_country,
      iso_region: iso_region,
      municipality: municipality,
      scheduled_service: scheduled_service,
      gps_code: gps_code,
      iata_code: iata_code,
      local_code: local_code,
      home_link: home_link,
      wikipedia_link: wikipedia_link,
      keywords: keywords
    }
  end) |> Enum.to_list

  def all() do
    @airports
  end
end
