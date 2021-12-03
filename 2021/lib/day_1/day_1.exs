defmodule Aoc2021.Day1 do
  def part_1(input) do
    {answer, _} =
      Enum.reduce(input, {0, nil}, fn
        x, {count, prev} when x > prev -> {count + 1, x}
        x, {count, _prev} -> {count, x}
      end)

    answer
  end

  def part_2(input) do
    input
    |> Stream.chunk_every(3, 1, :discard)
    |> Stream.map(&Enum.sum/1)
    |> part_1
  end
end

_input = [
  199,
  200,
  208,
  210,
  200,
  207,
  240,
  269,
  260,
  263
]

input2 = Aoc2021.load_input("./lib/day_1/input.txt") |> Stream.map(&String.to_integer/1)

Aoc2021.Day1.part_1(input2) |> IO.inspect(label: "part 1")
Aoc2021.Day1.part_2(input2) |> IO.inspect(label: "part 2")
