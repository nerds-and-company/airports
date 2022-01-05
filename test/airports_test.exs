defmodule AirportsTest do
  use ExUnit.Case

  test "all/0 returns all the airports" do
    total_airports =
      [__DIR__, "../priv", "airports.dat"]
      |> Path.join()
      |> File.stream!([], :line)
      |> CSV.decode()
      |> Enum.count()

    assert Enum.count(Airports.all()) == total_airports
  end
end
