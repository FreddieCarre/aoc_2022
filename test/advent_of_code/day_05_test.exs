defmodule AdventOfCode.Day05Test do
  use ExUnit.Case

  import AdventOfCode.Day05

  test "part1" do
    input = "    [D]     \n[N] [C]     \n[Z] [M] [P] \n 1   2   3 \n\nmove 1 from 2 to 1\nmove 3 from 1 to 3\nmove 2 from 2 to 1\nmove 1 from 1 to 2"
    result = part1(input)

    assert result == "CMZ"
  end

  test "part2" do
    input = "    [D]     \n[N] [C]     \n[Z] [M] [P] \n 1   2   3 \n\nmove 1 from 2 to 1\nmove 3 from 1 to 3\nmove 2 from 2 to 1\nmove 1 from 1 to 2"
    result = part2(input)

    assert result == "MCD"
  end
end
