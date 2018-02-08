defmodule InterfaceWeb.ErrorView do
  use InterfaceWeb, :view

  def render(_, %{errors: errors}) do
    errors
    |> format_error()
    |> build_message()
  end
  
  defp format_error(errors) when is_list(errors) do
    errors |> Enum.map(&format_error(&1))
  end
  defp format_error(error) when is_map(error), do: [error]
  defp format_error(error), do: [%{message: error}]
  
  defp build_message(errors) do
    %{data: %{errors: errors }}
  end
end
