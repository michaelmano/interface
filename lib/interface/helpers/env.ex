defmodule Interface.Env do
  @moduledoc """
  Loads the .env file into memory and sets system environment variables.
  """
  @doc false
  def run do
    case File.read(".env") do
      {:ok, body} -> load_env_into_memory(body)
      {:error, _} -> exit_application()
    end
  end

  @doc false
  defp load_env_into_memory(env) do
    env
    |> String.split("\n", trim: true)
    |> Enum.map(&format_command(&1))
  end

  @doc false
  defp format_command(cmd) do
    cmd
    |> String.split("=")
    |> Enum.chunk(2)
    |> Map.new(fn [k, v] -> {k, v} end)
    |> System.put_env()
  end

  defp exit_application() do
    IO.puts("Please make sure that the .env file exists and is formatted correctly, you can copy the .env.example.")
    System.stop
  end
end
