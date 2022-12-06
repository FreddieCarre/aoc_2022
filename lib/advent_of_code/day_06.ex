defmodule AdventOfCode.Day06 do
  def group_packets(input, chunk_by) do
    input
    |> String.codepoints()
    |> Enum.chunk_every(chunk_by, 1, :discard)
    |> Enum.with_index()
    |> Enum.reduce_while(:nil, fn {g, index}, acc ->
      is_start = Enum.count(Enum.uniq(g)) == Enum.count(g)

      if is_start, do: {:halt, index + chunk_by}, else: {:cont, acc}
    end)
  end

  def part1(args) do
    args
    |> group_packets(4)
  end

  def part2(args) do
    args
    |> group_packets(14)
  end
end
