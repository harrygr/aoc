defmodule Aoc2021.Day6 do
  def part_1(input) do
    fishes = prepare_input(input)

    Enum.reduce(1..80, fishes, fn _, f -> iterate(f) end) |> Enum.count()
  end

  def part_2(input) do
    fishes = prepare_input(input)

    fish_ages = Enum.frequencies(fishes)

    starting_ages =
      Enum.map(0..8, fn age -> Map.get(fish_ages, age, 0) end)
      |> List.to_tuple()

    Enum.reduce(1..256, starting_ages, fn _, f -> iterate_ages(f) end)
    |> Tuple.to_list()
    |> Enum.sum()
  end

  def iterate_ages({day0s, day1s, day2s, day3s, day4s, day5s, day6s, day7s, day8s}) do
    {day1s, day2s, day3s, day4s, day5s, day6s, day7s + day0s, day8s, day0s}
  end

  def iterate(fishes) do
    fishes
    |> Stream.flat_map(fn
      0 -> [6, 8]
      n -> [n - 1]
    end)
  end

  def prepare_input(input) do
    input
    |> String.split(",", trim: true)
    |> Stream.map(&String.to_integer/1)
  end
end

input = "3,4,3,1,2"

input2 = File.read!("./lib/day_6/input.txt")

# Aoc2021.Day6.part_1(input2) |> IO.inspect(label: "part 1")
Aoc2021.Day6.part_2(input2) |> IO.inspect(label: "part 2")
