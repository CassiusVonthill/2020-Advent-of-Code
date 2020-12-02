defmodule Aoc2020.Day01 do
  def part1(data) do
    data
    |> Stream.map(&String.to_integer/1)
    |> Enum.filter(&(&1 <= 2020))
    |> match(2020)
    |> Enum.reduce(&*/2)
  end

  def match(data, sum), do: match(data, sum, %{})

  def match([h | t], sum, db) do
    case Map.fetch(db, h) do
      {:ok, value} -> [value, h]
      _ -> match(t, sum, Map.put_new(db, sum - h, h))
    end
  end

  def match([], _sum, _acc), do: []

  def part2(data) do
    data
    |> Enum.map(&String.to_integer/1)
    |> Enum.filter(&(&1 <= 2020))
    |> compute(2020)
    |> Enum.reduce(&*/2)
  end

  def compute(data, sum) do
    is_goal = fn x, y, z -> x + y + z == sum end

    for a <- data,
        b <- data,
        c <- data,
        is_goal.(a, b, c) do
      [a, b, c]
    end
    |> List.flatten()
    |> Enum.uniq()
    |> IO.inspect()
  end
end
