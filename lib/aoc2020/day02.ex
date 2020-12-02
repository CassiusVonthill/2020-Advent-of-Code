defmodule Aoc2020.Day02 do
  @regex ~r"(\d+)-(\d+) (\w): (\w+)"

  def part1(data) do
    data
    |> Stream.map(&valid_count_password?(&1, @regex))
    |> Enum.count(& &1)
  end

  def valid_count_password?(entry, regex) do
    [_, bot, top, item, password] = Regex.run(regex, entry)

    [bot, top] = Enum.map([bot, top], &String.to_integer/1)

    cnt =
      password
      |> String.graphemes()
      |> Enum.count(&(&1 == item))

    bot <= cnt and cnt <= top
  end

  def part2(data) do
    data
    |> Stream.map(&valid_index_password?(&1, @regex))
    |> Enum.count(& &1)
  end

  def valid_index_password?(entry, regex) do
    [_, bot, top, item, password] = Regex.run(regex, entry)

    indexes = Enum.map([bot, top], &String.to_integer/1)

    cnt =
      password
      |> String.graphemes()
      |> Stream.with_index(1)
      |> Stream.filter(fn {_, y} -> y in indexes end)
      |> Stream.map(&elem(&1, 0))
      |> Enum.count(&(&1 == item))

    cnt == 1
  end
end
