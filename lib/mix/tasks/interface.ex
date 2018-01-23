defmodule Mix.Tasks.Interface do
  use Mix.Task
  @shortdoc "Offers commands to start or refresh the database."
  @prompt [
    "Select from the following options:",
    "1) Start Application",
    "2) Drop, Create and seed database",
    "3) Exit",
  ]
  |> Enum.join("\n")

  def run(_) do
    load_env()
    prompt_user()
  end

  defp load_env() do
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

  defp prompt_user(prompt \\ @prompt) do
    prompt
    |> IO.puts
    IO.gets(": ")
    |> determine_user_selection()
  end

  defp determine_user_selection(cmd) do
    cmd
    |> String.replace(~r/\r|\n/, "")
    |> String.to_integer
    |> case do
      1 -> start_application
      2 -> reload_database
      3 -> :exit
      _ -> prompt_user("Option not available.")
    end
  end

  defp start_application do
    IO.puts("This is currently in development, Please run 'iex -S mix phx.server' from your terminal.")
    # System.cmd("iex", ["-S", "mix", "phx.server"], [stderr_to_stdout: true])
  end

  defp reload_database do
    IO.puts("This is currently in development.")
  end
end
