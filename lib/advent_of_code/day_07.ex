defmodule AdventOfCode.Day07 do
  defp parse_input(input) do
    String.split(input, "\n", trim: true)
  end

  defp add_to_dir(fs, dir, val) do
    old_dir = Map.get(fs, dir, [])
    new_dir = [val | old_dir]

    Map.put(fs, dir, new_dir)
  end

  defp build_fs(cmds) do
    build_fs(%{}, cmds, nil)
  end

  defp build_fs(fs, [], _) do
    fs
  end

  defp build_fs(fs, [cmd | tail], cwd) do
    case cmd do
      "$ cd /" ->
        new_cwd = "/"
        build_fs(fs, tail, new_cwd)

      "$ cd " <> directory ->
        new_cwd = Path.expand(directory, cwd)
        build_fs(fs, tail, new_cwd)

      "$ ls" ->
        build_fs(fs, tail, cwd)

      "dir " <> dirname ->
        new_fs = add_to_dir(fs, cwd, { "d", dirname })
        build_fs(new_fs, tail, cwd)

      _ ->
        [size, _] = String.split(cmd, " ")
        { i_size, _ } = Integer.parse(size)
        new_fs = add_to_dir(fs, cwd, { "f", i_size })
        build_fs(new_fs, tail, cwd)
    end
  end

  defp get_size(fs) do
    fs
    |> Enum.map(fn {dir, _} -> get_size(fs, dir) end)
  end

  defp get_size(fs, dir) do
    Map.get(fs, dir)
    |> Enum.map(fn {type, x} ->
      if type == "d" do
        get_size(fs, Path.expand(x, dir))
      else
        x
      end
    end)
    |> Enum.sum()
  end

  defp get_fs_size(args) do
    args
    |> parse_input()
    |> build_fs()
    |> get_size()
  end

  def part1(args) do
    args
    |> get_fs_size()
    |> Enum.filter(fn x -> x <= 100000 end)
    |> Enum.sum()
  end

  def part2(args) do
    total_disk_space = 70000000
    min_disk_space = 30000000

    fs = args
    |> parse_input()
    |> build_fs()

    used_size = get_size(fs, "/")

    required_space = min_disk_space - (total_disk_space - used_size)

    fs
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.map(&hd/1)
    |> Enum.map(fn dir -> get_size(fs, dir) end)
    |> Enum.filter(fn x -> x > required_space end)
    |> Enum.min()
  end
end
