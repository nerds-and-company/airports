defmodule AirportsTest do
  use ExUnit.Case

  test "all/0 returns all the airports" do
    lines_count_from_source =
      [__DIR__, "../priv", "airports.csv"]
      |> Path.join()
      |> File.stream!([], :line)
      |> Enum.count()
      # minus header
      |> Kernel.-(1)

    assert Enum.count(Airports.all()) == lines_count_from_source
  end

  test "get_airport/1 returns an airport struct, null if not exist" do
    assert %Airports.Airport{iata_code: "JFK"} = Airports.get_airport("JFK")
    refute Airports.get_airport("NOT_EXIST")
  end

  test "get_timezone/1 returns timezone of an airport, null if not exist" do
    assert Airports.get_timezone("JFK") == "America/New_York"
    refute Airports.get_timezone("NOT_EXIST")
  end
end
