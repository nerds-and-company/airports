defmodule AirportsTest do
  use ExUnit.Case

  test "all/0 returns all the airports" do
    assert Enum.count(Airports.all()) == 7184
  end
end
