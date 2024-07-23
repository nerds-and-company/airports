defmodule Airports do
  @moduledoc """
  Airports main API
  """
  alias Airports.Airport

  @source_path Airports.Loader.source_path()
  @airports if File.exists?(@source_path), do: Airports.Loader.run(), else: []

  @spec all() :: [Airport.t()]
  def all, do: @airports

  @spec get_airport(String.t()) :: Airport.t() | nil
  def get_airport(iata_code) do
    Enum.find(all(), &(&1.iata_code == iata_code))
  end

  @spec get_timezone(String.t()) :: String.t() | nil
  def get_timezone(iata_code) do
    iata_code
    |> get_airport()
    |> case do
      nil -> nil
      airport -> airport.timezone_id
    end
  end
end
