defmodule GameOfLife.VisualizationChannel do
  @moduledoc false

  use GameOfLife.Web, :channel

  def join("visualization", _message, socket) do
    {:ok, socket}
  end
end
