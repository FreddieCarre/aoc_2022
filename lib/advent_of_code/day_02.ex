defmodule AdventOfCode.Day02 do
  def parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn round -> String.split(round, " ", trim: true) end)
  end

  def score_round(r) do
    score = fn
      ["A", "X"] -> 4
      ["B", "X"] -> 1
      ["C", "X"] -> 7
      ["A", "Y"] -> 8
      ["B", "Y"] -> 5
      ["C", "Y"] -> 2
      ["A", "Z"] -> 3
      ["B", "Z"] -> 9
      ["C", "Z"] -> 6
      _ -> 0
    end

    score.(r)
  end

  def part1(args) do
    args
    |> parse
    |> Enum.map(&score_round/1)
    |> Enum.sum()
  end

  def get_draw(t) do
    draw = fn
      "A" -> "X"
      "B" -> "Y"
      "C" -> "Z"
      _ -> ""
    end

    draw.(t)
  end

  def get_win(t) do
    win = fn
      "A" -> "Y"
      "B" -> "Z"
      "C" -> "X"
      _ -> ""
    end

    win.(t)
  end

  def get_loss(t) do
    win = fn
      "A" -> "Z"
      "B" -> "X"
      "C" -> "Y"
      _ -> ""
    end

    win.(t)
  end

  def get_throw(r) do
   get = fn
      [opp, "X"] -> get_loss(opp)
      [opp, "Y"] -> get_draw(opp)
      [opp, "Z"] -> get_win(opp)
      _-> 0
    end

    get.(r)
  end

  def part2(args) do
    args
    |> parse
    |> Enum.map(fn r = [opp, _] -> [opp, get_throw(r)] end)
    |> Enum.map(&score_round/1)
    |> Enum.sum
  end
end
