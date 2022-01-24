defmodule AirportsTest do
  use ExUnit.Case

  test "all/0 returns all the airports" do
    lines_count_from_source =
      [__DIR__, "../priv", "airports.dat"]
      |> Path.join()
      |> File.stream!([], :line)
      |> Enum.to_list()
      |> Enum.count()

    assert Enum.count(Airports.all()) == lines_count_from_source
  end
end
