defmodule GameOfLife do
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      supervisor(GameOfLife.Endpoint, []),
    ]

    opts = [strategy: :one_for_one, name: GameOfLife.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    GameOfLife.Endpoint.config_change(changed, removed)
    :ok
  end
end
