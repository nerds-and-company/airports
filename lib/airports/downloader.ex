defmodule Airports.Downloader do
  @moduledoc "Simple downloader using Erlang HTTP Client"

  def download(url, output_path) do
    :inets.start()
    :ssl.start()

    url = String.to_charlist(url)

    case :httpc.request(:get, {url, []}, [], []) do
      {:ok, {{_, 200, _}, _headers, body}} ->
        File.write(output_path, body)

      {:ok, {{_, status_code, _}, _, _}} ->
        {:error, "HTTP request failed with status code #{status_code}"}

      {:error, reason} ->
        {:error, "Failed to download: #{inspect(reason)}"}
    end
  end
end
