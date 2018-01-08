defmodule InterfaceWeb.AvatarsResolver do
  alias Interface.Avatars

  def all_characters(_root, _args, _info) do
    characters = Avatars.list_characters()
    {:ok, characters}
  end

  def all_classes(_root, _args, _info) do
    classes = Avatars.list_classes()
    {:ok, classes}
  end
end