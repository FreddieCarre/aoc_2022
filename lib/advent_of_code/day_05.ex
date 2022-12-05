defmodule AdventOfCode.Day05 do
  defp parse_crates(c) do
    [keys | crates] = String.split(c, "\n", trim: true)
    |> Enum.reverse()
    |> Enum.map(fn x -> String.codepoints(x) end)

    columns = Enum.with_index(keys)
    |> Enum.reduce(%{}, fn {ele, index}, acc ->
      case ele do
        " " -> acc
        "" -> acc
        x -> Map.put(acc, index, %{:index => index, :column => x, :crates => []})
      end
    end)

    Map.to_list(columns)
    |> Enum.map(fn {index, col} ->
      c = Enum.map(crates, fn row ->
        {_, item} = Enum.fetch(row, index)
        item
      end)
      |> Enum.filter(fn x -> x |> String.trim() |> String.length() > 0 end)

      {index, %{:index => index, :column => Map.get(col, :column), :crates => c}}
    end)
    |> Enum.reduce(%{}, fn {_, c}, acc ->
      {col, _} = Map.get(c, :column)
      |> Integer.parse()
      Map.put(acc, col, c)
    end)
  end

  defp parse_instructions(i) do
    i
    |> String.split("\n", trim: true)
    |> Enum.map(fn x ->
      %{"start" => s, "count" => c, "target" => t} = Regex.named_captures(~r/move (?<count>\d+?) from (?<start>\d+?) to (?<target>\d+?)/, x)

      {start, _} = Integer.parse(s)
      {count, _} = Integer.parse(c)
      {target, _} = Integer.parse(t)

      %{:start => start, :count => count, :target => target}
    end)
  end

  defp move(input) do
    [crates, inst] = String.split(input, "\n\n", trim: true)

    c = parse_crates(crates)
    i = parse_instructions(inst)

    Enum.reduce(i, c, fn %{start: start, count: count, target: target}, acc ->
      Enum.reduce(0..count-1, acc, fn _, ac ->
        start_row = Map.get(ac, start)

        to_move = start_row
        |> Map.get(:crates)
        |> Enum.reverse()
        |> hd()

        updated_start = Map.update!(ac, start, fn s ->
          Map.update!(s, :crates, fn c ->
            c |> Enum.reverse() |> tl() |> Enum.reverse()
          end)
        end)
        Map.update!(updated_start, target, fn s ->
          Map.update(s, :crates, [], fn c ->
            Enum.concat(c, [to_move])
          end)
        end)
      end)
    end)
  end

  defp move_two(input) do
    [crates, inst] = String.split(input, "\n\n", trim: true)

    c = parse_crates(crates)
    i = parse_instructions(inst)

    Enum.reduce(i, c, fn %{start: start, count: count, target: target}, acc ->
      start_row = Map.get(acc, start)

      to_move = start_row
      |> Map.get(:crates)
      |> Enum.reverse()
      |> Enum.slice(0, count)
      |> Enum.reverse()

      updated_start = Map.update!(acc, start, fn s ->
        Map.update!(s, :crates, fn c ->
          c |> Enum.slice(0, Enum.count(c) - count)
        end)
      end)
      Map.update!(updated_start, target, fn s ->
        Map.update(s, :crates, [], fn c ->
          Enum.concat(c, to_move)
        end)
      end)
    end)
  end

  def part1(args) do
    args
    |> move()
    |> Map.to_list()
    |> Enum.reduce("", fn {_, ele}, x ->
      y = Map.get(ele, :crates) |> Enum.reverse() |> Enum.at(0)
      x <> y
    end)
  end

  def part2(args) do
    args
    |> move_two()
    |> Map.to_list()
    |> Enum.reduce("", fn {_, ele}, x ->
      y = Map.get(ele, :crates) |> Enum.reverse() |> Enum.at(0)
      x <> y
    end)
  end
end
