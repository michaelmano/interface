defmodule Interface.Repo do
  use Ecto.Repo, otp_app: :interface

  @doc """
  Loads the .env file into memory and sets environment
  variables and sets the config options with them.
  """
  def init(_, opts) do
    File.read(".env")
    |> Tuple.to_list
    |> List.last
    |> String.split("\n", trim: true)
    |> Enum.map(&format_command(&1) |> System.put_env())
    |> format_options(opts)
  end

  defp format_options(_, opts) do
    {:ok, opts
    |> Keyword.put(:url, System.get_env("DATABASE_URL"))
    |> Keyword.put(:database, System.get_env("DATABASE_NAME"))
    |> Keyword.put(:username, System.get_env("DATABASE_USERNAME"))
    |> Keyword.put(:password, System.get_env("DATABASE_PASSWORD"))}
  end

  defp format_command(cmd) do
    cmd
    |> String.split("=")
    |> Enum.chunk(2)
    |> Map.new(fn [k, v] -> {k, v} end)
  end
end
