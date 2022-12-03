defmodule AdventOfCode.Day03 do
  defp parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> String.split_at(Integer.floor_div(String.length(line), 2))
      |> Tuple.to_list()
    end)
  end

  defp get_priority(<<cp::utf8>> = item) do
    if item == String.upcase(item) do
      Integer.mod(cp, ?A) + 27
    else
      Integer.mod(cp, ?a) + 1
    end
  end

  defp get_dup([a, b]) do
    MapSet.intersection(a, b)
    |> MapSet.to_list()
  end

  defp get_dup([a, b, c]) do
    MapSet.intersection(a, b)
    |> MapSet.intersection(c)
    |> MapSet.to_list()
  end

  def part1(args) do
    args
    |> parse()
    |> Enum.map(fn bag ->
      bag
      |> Enum.map(fn container ->
        String.split(container, "", trim: true)
        |> MapSet.new()
      end)
      |> get_dup()
    end)
    |> Enum.map(fn x -> String.normalize(Enum.at(x, 0), :nfc) end)
    |> Enum.map(&get_priority/1)
    |> Enum.sum()
  end

  def part2(args) do
    args
    |> String.split("\n", trim: true)
    |> Enum.map(fn bag -> MapSet.new(String.split(bag, "", trim: true)) end)
    |> Enum.chunk_every(3)
    |> Enum.map(fn group -> get_dup(group) end)
    |> Enum.map(fn x -> String.normalize(Enum.at(x, 0), :nfc) end)
    |> Enum.map(&get_priority/1)
    |> Enum.sum()
  end
end
