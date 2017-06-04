defmodule GameOfLife.UserSocket do
  @moduledoc false

  use Phoenix.Socket

  channel "visualization", GameOfLife.VisualizationChannel

  transport :websocket, Phoenix.Transports.WebSocket

  def connect(_params, socket) do
    {:ok, socket}
  end

  def id(_socket), do: nil
end
