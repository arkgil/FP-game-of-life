defmodule GameOfLife do
  @moduledoc """
  Process periodically calculating steps of Game of Life
  """

  use GenServer

  alias GameOfLife.Board

  require Record
  require Logger

  @default_interval 1_000
  @supervisor GameOfLife.Supervisor
  @channel_topic "visualization"

  Record.defrecordp :state, [:board, interval: @default_interval]

  @type interval :: pos_integer
  @typep state :: record(:state, interval: interval, board: Board.t)

  ## API

  @doc """
  Starts the simulation given initial board and
  """
  @spec start([row :: [Board.cell_state]]) :: Supervisor.on_start_child
  @spec start([row :: [Board.cell_state]], interval) :: Supervisor.on_start_child
  def start(rows, interval \\ @default_interval) do
    Supervisor.start_child(@supervisor, child_spec(rows, interval))
  end

  @doc false
  @spec start_link([row :: [Board.cell_state]], interval) :: GenServer.on_start
  def start_link(rows, interval) do
    GenServer.start_link(__MODULE__, [rows, interval], name: __MODULE__)
  end

  @doc """
  Stops the simulation
  """
  @spec stop :: :ok
  def stop do
    with :ok <- Supervisor.terminate_child(@supervisor, __MODULE__),
         :ok <- Supervisor.delete_child(@supervisor, __MODULE__) do
      :ok
    end
  end

  ## GenServer callbacks

  def init([rows, interval]) do
    board = Board.new(rows)
    broadcast_cells(board)
    Logger.debug "\n#{board}"
    schedule_transition(interval)
    {:ok, state(interval: interval, board: board)}
  end

  def handle_info(:transition, state(interval: interval, board: board) = state) do
    new_board = Board.transition(board)
    Logger.debug "\n#{new_board}"
    broadcast_cells(new_board)
    schedule_transition(interval)
    {:noreply, state(state, board: new_board)}
  end

  def terminate(_, _) do
    :ok
  end

  ## Internal functions

  defp child_spec(rows, interval) do
    Supervisor.Spec.worker(__MODULE__, [rows, interval])
  end

  defp schedule_transition(interval) do
    Process.send_after self(), :transition, interval
    :ok
  end

  defp broadcast_cells(board) do
    cells = listify_cells(board.cells)
    generation = %{cells: cells, step: board.step}
    GameOfLife.Endpoint.broadcast! @channel_topic, "new:generation", generation
  end

  defp listify_cells(cells) do
    cells
    |> Enum.reduce([], &listify_row/2)
    |> List.flatten()
  end

  defp listify_row({row_index, row}, acc) do
    row_as_list = Enum.reduce(row, [], fn {col_index, cell_state}, acc ->
      cell = %{row: row_index,
               col: col_index,
               state: %{
                 color: cell_color(cell_state)
               }}
      [cell | acc]
    end)
    [row_as_list | acc]
  end

  defp cell_color(1), do: "green"
  defp cell_color(0), do: "red"
end
