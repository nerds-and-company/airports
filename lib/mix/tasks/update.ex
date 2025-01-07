defmodule Mix.Tasks.Airports.Update do
  @moduledoc """
  Updates the latest timezone data of each airport and save it on the timezone_id column of airports.csv
  """

  @shortdoc "Update airports with timezone data"

  @source_link "https://raw.githubusercontent.com/davidmegginson/ourairports-data/refs/heads/main/airports.csv"
  @source_file "airports.csv"
  @destination_path Path.join([:code.priv_dir(:airports), "airports_with_tz.csv"])

  use Mix.Task
  require Logger
  alias Airports.Downloader

  def run(_args) do
    restart_backends()
    Process.put(:lines, 0)

    source_file = Path.join([:code.priv_dir(:airports), @source_file])

    Mix.shell().info("Downloading airports from #{@source_link}...")
    :ok = download_source(@source_link, source_file)
    Mix.shell().info("Successfully downloaded airports data!")

    stream = File.stream!(source_file)

    total_lines = Enum.count(stream)

    Mix.shell().info("Loading airports from #{@source_file}...")

    stream
    |> AirportsParser.parse_stream(skip_headers: false)
    |> Stream.map(fn
      ["id" | _] = headers ->
        display_progress(total_lines)
        headers ++ ["timezone_id"]

      line ->
        [
          _,
          _ident,
          _type,
          _name,
          latitude,
          longitude,
          _elevation_ft,
          _continent,
          _iso_country,
          _iso_region,
          _municipality,
          _scheduled_service,
          _gps_code,
          _iata_code,
          _local_code,
          _home_link,
          _wikipedia_link,
          _keywords
        ] = line

        timezone_id = get_timezone(longitude, latitude)
        display_progress(total_lines)
        line ++ [timezone_id]
    end)
    |> AirportsParser.dump_to_iodata()
    |> then(&File.write!(@destination_path, &1))

    Mix.shell().info("\nSuccessfully saved airports data!")
  end

  defp display_progress(total_lines) do
    Process.put(:lines, Process.get(:lines) + 1)
    IO.write("\rUpdating timezone data #{div(Process.get(:lines) * 100, total_lines)}%...")
  end

  defp get_timezone(long, lat) do
    with {long, _} <- Float.parse(long),
         {lat, _} <- Float.parse(lat),
         {:ok, tz} <- TzWorld.timezone_at({long, lat}) do
      tz
    else
      _ -> nil
    end
  end

  defp restart_backends do
    GenServer.stop(TzWorld.Backend.Memory)
    GenServer.stop(TzWorld.Backend.Dets)
    TzWorld.Backend.Memory.start_link()
    TzWorld.Backend.Dets.start_link()
  end

  defp download_source(url, output_path) do
    case Downloader.download(url, output_path) do
      {:error, reason} -> Mix.shell().error(reason)
      result -> result
    end
  end
end
