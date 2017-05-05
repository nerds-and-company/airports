defmodule Airports.Mixfile do
  use Mix.Project

  def project do
    [app: :airports,
     version: "0.1.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     description: description(),
     package: package(),
     source_url: "https://github.com/nerds-and-company/airports"]
  end

  def application do
    [extra_applications: [:logger]]
  end

  defp deps do
    [
      {:csv, "~> 1.4.2"}
    ]
  end

  defp description do
    """
    Airports is a collection of all known airports. Data source is https://openflights.org/data.html
    """
  end

  defp package do
    [maintainers: ["Don Pinkster"],
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/nerds-and-company/airports"}]
  end
end
