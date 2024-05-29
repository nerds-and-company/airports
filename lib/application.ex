defmodule Airports.Application do
  @moduledoc false
  use Application
  @on_load :update_timezones

  def update_timezones do
    Mix.Tasks.TzWorld.Update.update(false, true)
    :ok
  end

  def start(_start_type, _start_args) do
    children = [TzWorld.Backend.DetsWithIndexCache]
    opts = [strategy: :one_for_one, name: Airports.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
