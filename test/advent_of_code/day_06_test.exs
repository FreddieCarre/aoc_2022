defmodule AdventOfCode.Day06Test do
  use ExUnit.Case

  import AdventOfCode.Day06

  test "part1" do
    [
      {"bvwbjplbgvbhsrlpgdmjqwftvncz", 5},
      {"nppdvjthqldpwncqszvftbrmjlhg", 6},
      {"nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg", 10},
      {"zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw", 11}
    ]
    |> Enum.each(fn {input, exp} ->
      result = part1(input)

      assert result == exp
    end)
  end

  test "part2" do
    [
      {"mjqjpqmgbljsphdztnvjfqwrcgsmlb", 19},
      {"bvwbjplbgvbhsrlpgdmjqwftvncz", 23},
      {"nppdvjthqldpwncqszvftbrmjlhg", 23},
      {"nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg", 29},
      {"zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw", 26}
    ]
    |> Enum.each(fn {input, exp} ->
      result = part2(input)

      assert result == exp
    end)
  end
end
