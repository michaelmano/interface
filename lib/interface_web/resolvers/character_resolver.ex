defmodule InterfaceWeb.AvatarsResolver do
  alias Interface.Avatars

  def all_characters(_root, _args, _info) do
    characters = Avatars.list_characters()
    {:ok, characters}
  end

  def my_characters(_root, args, _info) do
    characters = Avatars.my_characters!(args[:user_id])
    {:ok, characters}
  end
end