defmodule Aoc2021.Day4 do
  def part_1(input) do
    {numbers, boards} = prepare_input(input)
    {n, winning_board} = find_first_winner(numbers, boards, 0)

    unmarked_sum = sum_unmarked(winning_board)

    unmarked_sum * n
  end

  def part_2(input) do
    {numbers, boards} = prepare_input(input)
    {n, winning_board} = find_last_winner(numbers, boards, 0)

    unmarked_sum = sum_unmarked(winning_board)

    unmarked_sum * n
  end

  def prepare_input(input) do
    [numbers | boards] =
      input
      |> String.split("\n\n", trim: true)

    boards =
      boards
      |> Stream.map(&String.split(&1, "\n", trim: true))
      |> Stream.map(fn board ->
        board
        |> Stream.map(&String.split(&1, " ", trim: true))
        |> Enum.reduce(&(&2 ++ &1))
        |> Stream.with_index()
        |> Stream.map(fn {n, i} ->
          col = rem(i, 5)
          row = div(i, 5)
          {{col, row}, {n, false}}
        end)
        |> Enum.into(%{})
      end)
      |> Enum.into([])

    {numbers |> String.split(",") |> List.to_tuple(), boards}
  end

  def find_first_winner(numbers, boards, pos) do
    n = elem(numbers, pos)

    updated_boards = Enum.map(boards, &mark_board(&1, n))

    case Enum.find(updated_boards, &is_winner?/1) do
      nil -> find_first_winner(numbers, updated_boards, pos + 1)
      winning_board -> {String.to_integer(n), winning_board}
    end
  end

  def find_last_winner(numbers, boards, pos) do
    n = elem(numbers, pos)

    case boards
         |> Stream.map(&mark_board(&1, n))
         |> Stream.filter(&(!is_winner?(&1)))
         |> Enum.into([]) do
      # there's one board left, so it must be the last to win. Find its winning number before returning
      [last_board] -> find_first_winner(numbers, [last_board], pos + 1)
      losing_boards -> find_last_winner(numbers, losing_boards, pos + 1)
    end
  end

  defp mark_board(board, n) do
    board
    |> Stream.map(fn
      {c, {^n, _}} -> {c, {n, true}}
      v -> v
    end)
    |> Enum.into(%{})
  end

  defp is_winner?(board) do
    row_won?(board) or col_won?(board)
  end

  defp row_won?(board) do
    Enum.any?(0..4, fn row ->
      Enum.all?(0..4, fn col ->
        {_, marked} = Map.get(board, {col, row})
        marked
      end)
    end)
  end

  defp col_won?(board) do
    Enum.any?(0..4, fn col ->
      Enum.all?(0..4, fn row ->
        {_, marked} = Map.get(board, {col, row})
        marked
      end)
    end)
  end

  defp sum_unmarked(board) do
    board
    |> Stream.filter(fn
      {_, {_, false}} -> true
      _ -> false
    end)
    |> Stream.map(fn {_, {v, _}} -> String.to_integer(v) end)
    |> Enum.sum()
  end
end

input = """
7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1

22 13 17 11  0
8  2 23  4 24
21  9 14 16  7
6 10  3 18  5
1 12 20 15 19

3 15  0  2 22
9 18 13 17  5
19  8  7 25 23
20 11 10 24  4
14 21 16 12  6

14 21 17 24  4
10 16 15  9 19
18  8 23 26 20
22 11 13  6  5
2  0 12  3  7
"""

input2 = File.read!("./lib/day_4/input.txt")

# Aoc2021.Day4.part_1(input2) |> IO.inspect(label: "part 1")
Aoc2021.Day4.part_2(input2) |> IO.inspect(label: "part 2")
