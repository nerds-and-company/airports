defmodule Airports.Airport do
  defstruct [:name, :city, :country, :iata, :icao, :latitude, :longitude, :altitude,
             :timezone, :dst, :tz]
end