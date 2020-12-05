defmodule Aoc2020.Day04 do
  @fields ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]

  def part1(data) do
    data
    |> parse
    |> Enum.count(&has_fields(&1, @fields))
  end

  def part2(data) do
    data
    |> parse
    |> Stream.filter(&has_fields(&1, @fields))
    |> Stream.filter(&valid_fields/1)
    |> Enum.count()
  end

  def parse(data) do
    for passport <- String.split(data, "\n\n") do
      for pair <- String.split(passport), into: %{} do
        pair
        |> String.split(":")
        |> List.to_tuple()
      end
    end
  end

  def has_fields(passport, fields) when is_map(passport) do
    len = length(fields)

    passport
    |> Map.take(fields)
    |> map_size
    |> Kernel.==(len)
  end

  def str_in_range?(x, a, b) do
    x = String.to_integer(x)
    a <= x and x <= b
  end

  def valid_hgt?(hgt) do
    hgt
    |> String.at(-2)
    |> case do
      "c" -> String.slice(hgt, 0..-3) |> str_in_range?(150, 193)
      "i" -> String.slice(hgt, 0..-3) |> str_in_range?(59, 76)
      _ -> false
    end
  end

  def valid_fields(passport) do
    passport
    |> Enum.to_list()
    |> IO.inspect()
    |> Enum.map(fn
      {"byr", byr} -> str_in_range?(byr, 1920, 2002)
      {"iyr", iyr} -> str_in_range?(iyr, 2010, 2020)
      {"eyr", eyr} -> str_in_range?(eyr, 2020, 2030)
      {"hgt", hgt} -> valid_hgt?(hgt)
      {"hcl", hcl} -> Regex.match?(~r/^#[0-9a-f]{6}$/, hcl)
      {"ecl", ecl} -> Regex.match?(~r/^(amb)|(blu)|(brn)|(gry)|(grn)|(hzl)|(oth)$/, ecl)
      {"pid", pid} -> Regex.match?(~r/^[0-9]{9}$/, pid)
      {"cid", _cid} -> true
      _ -> false
    end)
    |> IO.inspect()
    |> Enum.all?()
  end
end
