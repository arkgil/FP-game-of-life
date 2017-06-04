defmodule GameOfLife.Board do
  @moduledoc """
  Pure data structure for calculating transitions of Game of Life
  """

  defstruct cells: %{}, step: 0

  @typep index :: non_neg_integer
  @type cell_state :: 1 | 0 ## 1 for alive, 0 for dead cell
  @type step :: non_neg_integer
  @typep cells :: %{
    row :: index => %{
      column :: index => cell_state
    }
  }
  @type t :: %__MODULE__{
    cells: cells,
    step: step
  }

  @doc """
  Returns new board filled with given cells
  """
  @spec new([row :: [cell_state, ...]]) :: t
  def new(rows) when is_list(rows) do
    %__MODULE__{cells: cells_from_rows(rows), step: 0}
  end

  @doc """
  Computes one step of automaton and returns updated board
  """
  @spec transition(t) :: t
  def transition(board) do
    next_step = board.step + 1
    new_cells = make_transition(board.cells)
    %__MODULE__{step: next_step, cells: new_cells}
  end

  ## Internals

  defp cells_from_rows(rows, acc \\ %{}, row_index \\ 0)
  defp cells_from_rows([], acc, _), do: acc
  defp cells_from_rows([row | rows], acc, row_index) do
    acc = Map.put(acc, row_index, columns_from_row(row))
    cells_from_rows(rows, acc, row_index + 1)
  end

  defp columns_from_row(row, acc \\ %{}, column_index \\ 0)
  defp columns_from_row([], acc, _), do: acc
  defp columns_from_row([cell_state | rest], acc, column_index) do
    acc = Map.put(acc, column_index, cell_state)
    columns_from_row(rest, acc, column_index + 1)
  end

  defp make_transition(cells) do
    Enum.reduce(cells, %{}, fn {row_index, row}, acc ->
      new_row = transition_row(row, row_index, cells)
      Map.put(acc, row_index, new_row)
    end)
  end

  defp transition_row(row, row_index, old_cells) do
    Enum.reduce(row, %{}, fn {col_index, cell_state}, acc ->
      new_cell_state =
        transition_cell(cell_state, row_index, col_index, old_cells)
      Map.put(acc, col_index, new_cell_state)
    end)
  end

  defp transition_cell(cell_state, row_index, col_index, old_cells) do
    {alive, dead} =
      {row_index, col_index}
      |> neighbours()
      |> Enum.reduce({0, 0}, fn {row, col}, {alive, dead} ->
        reduce_neighbours_state({row, col}, {alive, dead}, old_cells)
      end)
    make_cell_transition(cell_state, alive, dead)
  end

  defp neighbours({row_index, col_index}) do
    for row_offset <- [-1, 0, 1], col_offset <- [-1, 0, 1],
        {row_offset, col_offset} != {0, 0} do
        {row_index + row_offset, col_index + col_offset}
    end
  end

  defp reduce_neighbours_state({row_index, col_index}, {alive, dead}, cells) do
    row = Map.get(cells, row_index, %{})
    case Map.get(row, col_index) do
      1 -> {alive + 1, dead}
      0 -> {alive, dead + 1}
      _ -> {alive, dead}
    end
  end

  defp make_cell_transition(0, 3 = _alive, _), do: 1
  defp make_cell_transition(1, alive, _) when alive in 2..3, do: 1
  defp make_cell_transition(_, _, _), do: 0
end
