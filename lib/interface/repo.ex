defmodule Interface.Repo do
  use Ecto.Repo, otp_app: :interface
  @doc """
  Sets the option values for the database details.
  """
  def init(_, opts) do
    {:ok, Keyword.put(opts, :url, System.get_env("DATABASE_URL"))}
  end
end
