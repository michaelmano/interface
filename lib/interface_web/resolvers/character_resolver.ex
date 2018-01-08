defmodule InterfaceWeb.AvatarsResolver do
  alias Interface.Avatars

  def all_characters(_root, _args, _info) do
    characters = Avatars.list_characters()
    {:ok, characters}
  end

end