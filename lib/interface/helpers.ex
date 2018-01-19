defmodule Interface.Helpers do
  @doc """
  Simple helper functions that do not require their own module.
  """

  @doc false
  def init(opts), do: opts
  
  def mapify({k,v}, m), do: Map.put(m, k, v)
  
  def empty?([]), do: true
  def empty?(list) when is_list(list), do: false
end
