defmodule Aoc2021.Day3 do
  def part_1(input) do
    input
    |> Stream.map(&String.split(&1, "", trim: true))
    |> Stream.zip()
    |> Stream.map(&Tuple.to_list/1)
    |> Stream.map(fn bits ->
      Enum.reduce(bits, {0, 0}, fn
        "1", {zeros, ones} -> {zeros, ones + 1}
        "0", {zeros, ones} -> {zeros + 1, ones}
      end)
    end)
    |> Stream.map(fn
      {zeros, ones} when ones > zeros -> [1, 0]
      {zeros, ones} when ones < zeros -> [0, 1]
    end)
    |> Stream.zip()
    |> Stream.map(&Tuple.to_list/1)
    |> Stream.map(&Enum.join/1)
    |> Stream.map(&Integer.parse(&1, 2))
    |> Stream.map(fn {v, ""} -> v end)
    |> Enum.reduce(&(&1 * &2))
  end

  def part_2(input) do
    numbers =
      input
      |> Stream.map(&String.split(&1, "", trim: true))
      |> Stream.map(&List.to_tuple/1)
      |> Enum.into([])

    o2(numbers) * co2(numbers)
  end

  defp o2(numbers) do
    recur(numbers, 0, fn zero_count, one_count ->
      if zero_count > one_count, do: "0", else: "1"
    end)
  end

  defp co2(numbers) do
    recur(numbers, 0, fn zero_count, one_count ->
      if one_count < zero_count, do: "1", else: "0"
    end)
  end

  defp recur([n], _, _) do
    n |> Tuple.to_list() |> Enum.join() |> Integer.parse(2) |> elem(0)
  end

  defp recur(numbers, pos, compare) do
    zero_count = Enum.count(numbers, fn n -> elem(n, pos) == "0" end)
    one_count = length(numbers) - zero_count
    keep_num = compare.(zero_count, one_count)

    Enum.filter(numbers, fn n -> elem(n, pos) == keep_num end)
    |> recur(pos + 1, compare)
  end
end

input = [
  "00100",
  "11110",
  "10110",
  "10111",
  "10101",
  "01111",
  "00111",
  "11100",
  "10000",
  "11001",
  "00010",
  "01010"
]

input2 = Aoc2021.load_input("./lib/day_3/input.txt")

# Aoc2021.Day3.part_1(input2) |> IO.inspect(label: "part 1")
Aoc2021.Day3.part_2(input2) |> IO.inspect(label: "part 2")
