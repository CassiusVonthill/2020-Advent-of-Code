defmodule Aoc2020.Day03 do
  def part1(data) do
    data
    |> Stream.with_index()
    |> Stream.map(&count_trees_hit_by_slope(&1, {3, 1}))
    |> Enum.sum()
  end

  def part2(data) do
    data
    |> Stream.with_index()
    |> Stream.map(&count_trees_hit_by_slope(&1, [{1, 1}, {3, 1}, {5, 1}, {7, 1}, {1, 2}]))
    |> Enum.reduce(%{}, &Map.merge(&1, &2, fn _k, v1, v2 -> v1 + v2 end))
    |> Map.values()
    |> Enum.reduce(1, &*/2)
  end

  def count_trees_hit_by_slope(forest, slopes) when is_list(slopes) do
    slopes
    |> Stream.map(&count_trees_hit_by_slope(forest, &1))
    |> Stream.with_index()
    |> Map.new(fn {a, b} -> {b, a} end)
  end

  def count_trees_hit_by_slope({line, depth}, {dx, dy}) when rem(depth, dy) == 0 do
    len = byte_size(line)
    index = rem(div(dx * depth, dy), len)
    if tree?(line, index), do: 1, else: 0
  end

  def count_trees_hit_by_slope({_line, depth}, {_dx, dy}) when rem(depth, dy) != 0, do: 0

  @spec tree?({String.t(), non_neg_integer()}, non_neg_integer()) :: boolean()
  def tree?(line, index) do
    line
    |> binary_part(index, 1)
    |> Kernel.==("#")
  end
end
