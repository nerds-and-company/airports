NimbleCSV.define(AirportsParser, separator: ",", escape: "\"")

defmodule Airports.Loader do
  @moduledoc """
  Load airports from a CSV file
  """
  alias Airports.Airport
  # Tag as external_resource to ensure this module recompiles when this file changed
  @external_resource Path.join([:code.priv_dir(:airports), "airports_with_tz.csv"])

  def source_path, do: @external_resource

  def run do
    source_path()
    |> File.stream!()
    |> AirportsParser.parse_stream(skip_headers: true)
    |> Stream.map(fn line ->
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
        keywords,
        timezone_id
      ] = line

      %Airport{
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
        keywords: keywords,
        timezone_id: timezone_id
      }
    end)
    |> Enum.to_list()
  end
end
