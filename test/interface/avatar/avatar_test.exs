defmodule Interface.AvatarTest do
  use Interface.DataCase

  alias Interface.Avatar

  describe "classes" do
    alias Interface.Avatar.Class

    @valid_attrs %{description: "some description", excerpt: "some excerpt", name: "some name"}
    @update_attrs %{description: "some updated description", excerpt: "some updated excerpt", name: "some updated name"}
    @invalid_attrs %{description: nil, excerpt: nil, name: nil}

    def class_fixture(attrs \\ %{}) do
      {:ok, class} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Avatar.create_class()

      class
    end

    test "list_classes/0 returns all classes" do
      class = class_fixture()
      assert Avatar.list_classes() == [class]
    end

    test "get_class!/1 returns the class with given id" do
      class = class_fixture()
      assert Avatar.get_class!(class.id) == class
    end

    test "create_class/1 with valid data creates a class" do
      assert {:ok, %Class{} = class} = Avatar.create_class(@valid_attrs)
      assert class.description == "some description"
      assert class.excerpt == "some excerpt"
      assert class.name == "some name"
    end

    test "create_class/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Avatar.create_class(@invalid_attrs)
    end

    test "update_class/2 with valid data updates the class" do
      class = class_fixture()
      assert {:ok, class} = Avatar.update_class(class, @update_attrs)
      assert %Class{} = class
      assert class.description == "some updated description"
      assert class.excerpt == "some updated excerpt"
      assert class.name == "some updated name"
    end

    test "update_class/2 with invalid data returns error changeset" do
      class = class_fixture()
      assert {:error, %Ecto.Changeset{}} = Avatar.update_class(class, @invalid_attrs)
      assert class == Avatar.get_class!(class.id)
    end

    test "delete_class/1 deletes the class" do
      class = class_fixture()
      assert {:ok, %Class{}} = Avatar.delete_class(class)
      assert_raise Ecto.NoResultsError, fn -> Avatar.get_class!(class.id) end
    end

    test "change_class/1 returns a class changeset" do
      class = class_fixture()
      assert %Ecto.Changeset{} = Avatar.change_class(class)
    end
  end
end
