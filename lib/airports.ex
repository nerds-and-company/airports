NimbleCSV.define(AirportsParser, separator: ",", escape: "\"")

defmodule Airports do
  @moduledoc """
  Airports main API
  """
  alias Airports.Airport

  @airports [__DIR__, "../priv", "airports.csv"]
            |> Path.join()
            |> File.stream!([], :line)
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
                keywords
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
                keywords: keywords
              }
            end)
            |> Enum.to_list()

  @spec all() :: [Airport.t()]
  def all, do: @airports

  @spec get_airport(String.t()) :: Airport.t() | nil
  def get_airport(iata_code) do
    Enum.find(all(), &(&1.iata_code == iata_code))
  end

  @spec get_timezone(String.t()) :: String.t() | nil
  def get_timezone(iata_code) do
    with %Airport{longitude: long, latitude: lat} <- get_airport(iata_code),
         {long, _} <- Float.parse(long),
         {lat, _} <- Float.parse(lat),
         {:ok, tz} <- TzWorld.timezone_at({long, lat}) do
      tz
    else
      _ -> nil
    end
  end
end
