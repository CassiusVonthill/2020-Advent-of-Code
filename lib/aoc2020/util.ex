defmodule Aoc2020.Util do
  def load_input(day) do
    "test/prompts/day#{day}.txt"
    |> File.stream!()
    |> Enum.map(&String.trim/1)
  end
end
