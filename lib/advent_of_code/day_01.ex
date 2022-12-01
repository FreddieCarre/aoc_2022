defmodule AdventOfCode.Day01 do

  def part1(args) do
    args
    |> parse
    |> Enum.map(fn elf -> Enum.sum(elf) end)
    |> Enum.max()
  end

  def parse(args) do
    args
    |> String.split("\n\n", trim: true)
    |> Enum.map(fn elf ->
      elf
      |> String.split("\n", trim: true)
      |> Enum.map(&String.to_integer/1)
    end)
  end

  def part2(args) do
    args
    |> parse
    |> Enum.map(fn elf -> Enum.sum(elf) end)
    |> Enum.sort(fn a ,b -> b < a end)
    |> Enum.slice(0..2)
    |> Enum.sum
  end
end
