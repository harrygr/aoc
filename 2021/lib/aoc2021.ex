defmodule Aoc2021 do
  @moduledoc """
  Documentation for `Aoc2021`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Aoc2021.hello()
      :world

  """
  def hello do
    :world
  end

  def load_input(filename) do
    filename
    |> File.read!()
    |> String.split("\n", trim: true)
  end
end
