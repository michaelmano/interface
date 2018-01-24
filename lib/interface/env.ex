defmodule Interface.Env do
  @moduledoc """
  Loads the .env file into memory and sets system environment variables.
  """
  defmacro __using__(_), do: load_env()

  @doc false
  defp load_env do
    case File.read(".env") do
      {:ok, body} -> load_env_into_memory(body)
      {:error, error} -> exit_application(error)
    end
  end

  defp load_env_into_memory(env) do
    env
    |> Tuple.to_list
    |> List.last
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

  defp exit_application(error) do
    IO.inspect(error)
    IO.puts("An error has occured.")
    IO.puts("Please make sure of the following:")
    IO.puts("1) The .env file exists.")
    IO.puts("2) It has the correct formatting.")
    IO.puts("You can copy the .env.example")
    System.stop
  end
end
