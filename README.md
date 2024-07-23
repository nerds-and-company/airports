# Airports

Airports is a collection of all known airports. Data source is https://github.com/davidmegginson/ourairports-data

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `airports` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:airports, "~> 1.0"}]
end
```

## Adding timezone to the Airports data

Airports depends on [tz_world](https://github.com/kimlai/tz_world) for timezone data. After updating `priv/airports.csv`, run the following to add timezone data:

```elixir
mix airports.update
```

## Contributing

Before opening a pull request, please open an issue first.

Once we've decided how to move forward with a pull request:

    $ git clone https://github.com/nerds-and-company/airports.git
    $ cd airports
    $ mix deps.get
    $ mix test

Once you've made your additions and `mix test` passes, go ahead and open a PR!
