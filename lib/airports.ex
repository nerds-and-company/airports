defmodule Airports do
  data_file = Path.join([__DIR__,"../priv", "airports.dat"])
  @airports File.stream!(data_file, [], :line) |> CSV.decode |> Stream.map(fn(line) ->
    [_, name, city, country, iata, icao, latitude, longitude, altitude, timezone, dst, tz, _, _] = line

    %Airports.Airport{name: name, city: city, country: country, iata: iata, icao: icao, latitude: latitude,
                      longitude: longitude, altitude: altitude, timezone: timezone, dst: dst, tz: tz}
  end) |> Enum.to_list

  def all() do
    @airports
  end
end
