# This file is for adding short docs for mix aliases so they show up in the mix help command output.
defmodule Mix.Tasks.Ecto.Setup do
  use Mix.Task
  @shortdoc "Alias: ['ecto.create', 'ecto.migrate', 'run priv/repo/seeds.exs']"
  def run(_) do
  end
end

defmodule Mix.Tasks.Ecto.Reset do
  use Mix.Task
  @shortdoc "Alias: ['ecto.drop', 'ecto.setup']"
  def run(_) do
  end
end
