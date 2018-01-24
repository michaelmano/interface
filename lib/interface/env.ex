defmodule Interface.Env do
  @moduledoc """
  Loads the .env file into memory and sets system environment variables.
  """
  def load() do
    File.read(".env")
    |> Tuple.to_list
    |> List.last
    |> String.split("\n", trim: true)
    |> Enum.map(&format_command(&1) |> System.put_env())
  end

  defp format_command(cmd) do
    cmd
    |> String.split("=")
    |> Enum.chunk(2)
    |> Map.new(fn [k, v] -> {k, v} end)
  end
end
