defmodule Interface.AvatarsTest do
  use Interface.DataCase

  alias Interface.Avatars

  describe "characters" do
    alias Interface.Avatars.Character

    @valid_attrs %{bio: "some bio", name: "some name"}
    @update_attrs %{bio: "some updated bio", name: "some updated name"}
    @invalid_attrs %{bio: nil, name: nil}

    def character_fixture(attrs \\ %{}) do
      {:ok, character} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Avatars.create_character()

      character
    end

    test "list_characters/0 returns all characters" do
      character = character_fixture()
      assert Avatars.list_characters() == [character]
    end

    test "get_character!/1 returns the character with given id" do
      character = character_fixture()
      assert Avatars.get_character!(character.id) == character
    end

    test "create_character/1 with valid data creates a character" do
      assert {:ok, %Character{} = character} = Avatars.create_character(@valid_attrs)
      assert character.bio == "some bio"
      assert character.name == "some name"
    end

    test "create_character/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Avatars.create_character(@invalid_attrs)
    end

    test "update_character/2 with valid data updates the character" do
      character = character_fixture()
      assert {:ok, character} = Avatars.update_character(character, @update_attrs)
      assert %Character{} = character
      assert character.bio == "some updated bio"
      assert character.name == "some updated name"
    end

    test "update_character/2 with invalid data returns error changeset" do
      character = character_fixture()
      assert {:error, %Ecto.Changeset{}} = Avatars.update_character(character, @invalid_attrs)
      assert character == Avatars.get_character!(character.id)
    end

    test "delete_character/1 deletes the character" do
      character = character_fixture()
      assert {:ok, %Character{}} = Avatars.delete_character(character)
      assert_raise Ecto.NoResultsError, fn -> Avatars.get_character!(character.id) end
    end

    test "change_character/1 returns a character changeset" do
      character = character_fixture()
      assert %Ecto.Changeset{} = Avatars.change_character(character)
    end
  end

  describe "classes" do
    alias Interface.Avatars.Class

    @valid_attrs %{description: "some description", excerpt: "some excerpt", name: "some name"}
    @update_attrs %{description: "some updated description", excerpt: "some updated excerpt", name: "some updated name"}
    @invalid_attrs %{description: nil, excerpt: nil, name: nil}

    def class_fixture(attrs \\ %{}) do
      {:ok, class} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Avatars.create_class()

      class
    end

    test "list_classes/0 returns all classes" do
      class = class_fixture()
      assert Avatars.list_classes() == [class]
    end

    test "get_class!/1 returns the class with given id" do
      class = class_fixture()
      assert Avatars.get_class!(class.id) == class
    end

    test "create_class/1 with valid data creates a class" do
      assert {:ok, %Class{} = class} = Avatars.create_class(@valid_attrs)
      assert class.description == "some description"
      assert class.excerpt == "some excerpt"
      assert class.name == "some name"
    end

    test "create_class/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Avatars.create_class(@invalid_attrs)
    end

    test "update_class/2 with valid data updates the class" do
      class = class_fixture()
      assert {:ok, class} = Avatars.update_class(class, @update_attrs)
      assert %Class{} = class
      assert class.description == "some updated description"
      assert class.excerpt == "some updated excerpt"
      assert class.name == "some updated name"
    end

    test "update_class/2 with invalid data returns error changeset" do
      class = class_fixture()
      assert {:error, %Ecto.Changeset{}} = Avatars.update_class(class, @invalid_attrs)
      assert class == Avatars.get_class!(class.id)
    end

    test "delete_class/1 deletes the class" do
      class = class_fixture()
      assert {:ok, %Class{}} = Avatars.delete_class(class)
      assert_raise Ecto.NoResultsError, fn -> Avatars.get_class!(class.id) end
    end

    test "change_class/1 returns a class changeset" do
      class = class_fixture()
      assert %Ecto.Changeset{} = Avatars.change_class(class)
    end
  end
end
