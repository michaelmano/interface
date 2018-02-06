defmodule InterfaceWeb.ErrorView do
  use InterfaceWeb, :view
  alias Plug.Conn.Status

  def render("error.json", %{errors: errors}) do
    %{data: %{errors: build_error(errors)}}
  end

  defp build_error(errors) when is_list(errors) do
    Enum.map(errors, fn(error) ->
      %{message: error}
    end)
  end
  defp build_error(error), do: build_error([error])
end
