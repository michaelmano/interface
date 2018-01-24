defmodule Interface.DateTime do
  @moduledoc """
  A Module that returns date time helpers.
  """
  @hour 60000
  @minute 60000
  @second 1000
  @offset 36000000

  @doc "Returns the current server time in the format requested."
  def now(format \\ :unix) do
    case format do
      :unix -> unix()
    end
  end

  @doc "Returns the current server time in milliseconds."
  def unix(from \\ :os.system_time(:milli_seconds)) do
    from+@offset
  end

  @doc "TODO: Refactor to provide more options."
  def add(time, %{minutes: minutes}), do: time+minutes*@minute
  def add(time, %{seconds: seconds}), do: time+seconds*@second
end
