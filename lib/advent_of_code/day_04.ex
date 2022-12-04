defmodule AdventOfCode.Day04 do
  defp parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn pair -> String.split(pair, ",", trim: true) end)
    |> Enum.map(fn pair ->
      pair
      |> Enum.map(fn e ->
        e
        |> String.split("-", trim: true)
        |> Enum.map(fn s ->
          {n, _} = Integer.parse(s, 10)
          n
        end)
      end)
    end)
  end

  def part1(args) do
    args
    |> parse()
    |> Enum.filter(fn [[a1, a2], [b1, b2]] ->
      (a1 >= b1 && a2 <= b2) || (a1 <= b1 && a2 >= b2)
    end)
    |> Enum.count()
  end

  def part2(args) do
    args
    |> parse()
    |> Enum.filter(fn [[a1, a2], [b1, b2]] ->
      (a1 >= b1 && a1 <= b2) ||
        (a2 >= b1 && a2 <= b2) ||
        (b1 >= a1 && b1 <= a2) ||
        (b2 >= a1 && b2 <= a2)
    end)
    |> Enum.count()
  end
end
