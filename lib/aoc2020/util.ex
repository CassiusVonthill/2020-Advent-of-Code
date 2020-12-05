defmodule Aoc2020.Util do
  def load_lines(day) do
    "test/prompts/day#{day}.txt"
    |> File.stream!()
    |> Enum.map(&String.trim/1)
  end

  def load_string(day) do
    "test/prompts/day#{day}.txt"
    |> File.read!()
  end
end
