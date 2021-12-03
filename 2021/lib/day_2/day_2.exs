defmodule Aoc2021.Day2 do
  def part_1(input) do
    {h, d} =
      input
      |> prepare_input
      |> Enum.reduce({0, 0}, fn
        {:forward, x}, {h, d} -> {h + x, d}
        {:down, x}, {h, d} -> {h, d + x}
        {:up, x}, {h, d} -> {h, d - x}
      end)

    h * d
  end

  def part_2(input) do
    {h, d, _aim} =
      input
      |> prepare_input
      |> Enum.reduce({0, 0, 0}, fn
        {:up, x}, {h, d, aim} -> {h, d, aim - x}
        {:down, x}, {h, d, aim} -> {h, d, aim + x}
        {:forward, x}, {h, d, aim} -> {h + x, d + aim * x, aim}
      end)

    h * d
  end

  defp prepare_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Stream.map(fn
      "forward " <> x -> {:forward, String.to_integer(x)}
      "down " <> x -> {:down, String.to_integer(x)}
      "up " <> x -> {:up, String.to_integer(x)}
    end)
  end
end

_input = """
forward 5
down 5
forward 8
up 3
down 8
forward 2
"""

input2 = File.read!("./lib/day_2/input.txt")

Aoc2021.Day2.part_1(input2) |> IO.inspect(label: "part 1")
Aoc2021.Day2.part_2(input2) |> IO.inspect(label: "part 2")
