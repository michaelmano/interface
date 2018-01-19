defmodule Interface.Helpers do
  @doc """
  Simple helper functions that do not require their own module.
  """

  @doc false
  def init(opts), do: opts
  
  def mapify({k,v}, m) do
    Map.put(m, k, v)
  end

  def decode_basic_auth(headers) do
    headers
    |> List.to_string
    |> String.replace_prefix("Basic ", "")
    |> Base.decode64!
  end
end
