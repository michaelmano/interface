defmodule InterfaceWeb.AvatarsResolver do
  alias Interface.Avatars

  def all_classes(_root, _args, _info) do
    classes = Avatars.list_classes()
    {:ok, classes}
  end
end