defmodule Interface.Repo do
  use Ecto.Repo, otp_app: :interface
  @doc """
  Sets the option values for the database details.
  """
  def init(_, opts) do
    Interface.Env.run()
    {:ok, opts
    |> Keyword.put(:url, System.get_env("DATABASE_URL"))
    |> Keyword.put(:database, System.get_env("DATABASE_NAME"))
    |> Keyword.put(:username, System.get_env("DATABASE_USERNAME"))
    |> Keyword.put(:password, System.get_env("DATABASE_PASSWORD"))}
  end
end
