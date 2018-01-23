defmodule Mix.Tasks.Import.Env do
  use Mix.Task
  @shortdoc "Loads .env file and exports the private variables into memory."
  def run(_) do
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
