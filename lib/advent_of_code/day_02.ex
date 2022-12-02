defmodule AdventOfCode.Day02 do
  def parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn round -> String.split(round, " ", trim: true) end)
  end

  defp score({theirs, mine}) do
    mine + 1 + case Integer.mod(mine - theirs, 3) do
      0 -> 3
      1 -> 6
      2 -> 0
    end
  end

  def part1(args) do
    args
    |> String.split("\n", trim: true)
    |> Enum.map(fn <<theirs, " ", mine>> -> {theirs - ?A, mine - ?X} end)
    |> Enum.map(&score/1)
    |> Enum.sum
  end

  defp choose_move({theirs, outcome}) do
    {theirs, Integer.mod(theirs + (outcome - ?Y), 3)}
  end

  def part2(args) do
    args
    |> String.split("\n", trim: true)
    |> Enum.map(fn <<theirs, " ", mine>> -> {theirs - ?A, mine} end)
    |> Enum.map(&choose_move/1)
    |> Enum.map(&score/1)
    |> Enum.sum
  end
end
