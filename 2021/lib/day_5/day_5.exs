defmodule Aoc2021.Day5 do
  def part_1(input) do
    prepare_input(input)
    |> Stream.flat_map(fn
      {{x, y1}, {x, y2}} -> Stream.map(y1..y2, &{x, &1})
      {{x1, y}, {x2, y}} -> Stream.map(x1..x2, &{&1, y})
      _ -> []
    end)
    |> Enum.reduce(%{}, &count_points/2)
    |> Stream.filter(fn {_, c} -> c > 1 end)
    |> Enum.count()
  end

  def part_2(input) do
    prepare_input(input)
    |> Stream.flat_map(&get_lines/1)
    |> Enum.reduce(%{}, &count_points/2)
    |> Stream.filter(fn {_, c} -> c > 1 end)
    |> Enum.count()
  end

  def get_lines({{x, y1}, {x, y2}}), do: Stream.map(y1..y2, &{x, &1})
  def get_lines({{x1, y}, {x2, y}}), do: Stream.map(x1..x2, &{&1, y})
  def get_lines({{x1, y1}, {x2, y2}}), do: Enum.zip(x1..x2, y1..y2)

  def count_points(point, point_counts), do: Map.update(point_counts, point, 1, &(&1 + 1))

  def prepare_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Stream.map(fn row ->
      row
      |> String.split(" -> ", trim: true)
      |> Enum.map(fn coords ->
        coords
        |> String.split(",", trim: true)
        |> Enum.map(&String.to_integer/1)
        |> List.to_tuple()
      end)
    end)
    |> Stream.map(&List.to_tuple/1)
  end
end

_input = """
0,9 -> 5,9
8,0 -> 0,8
9,4 -> 3,4
2,2 -> 2,1
7,0 -> 7,4
6,4 -> 2,0
0,9 -> 2,9
3,4 -> 1,4
0,0 -> 8,8
5,5 -> 8,2
"""

input2 = File.read!("./lib/day_5/input.txt")

Aoc2021.Day5.part_1(input2) |> IO.inspect(label: "part 1")
Aoc2021.Day5.part_2(input2) |> IO.inspect(label: "part 2")
