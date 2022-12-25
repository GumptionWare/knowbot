defmodule Knowbot.KeywordsTest do
  use Knowbot.DataCase

  alias Knowbot.Keywords

  describe "keywords" do
    alias Knowbot.Keywords.Keyword

    import Knowbot.KeywordsFixtures

    @invalid_attrs %{name: nil}

    test "list_keywords/0 returns all keywords" do
      keyword = keyword_fixture()
      assert Keywords.list_keywords() == [keyword]
    end

    test "get_keyword!/1 returns the keyword with given id" do
      keyword = keyword_fixture()
      assert Keywords.get_keyword!(keyword.id) == keyword
    end

    test "create_keyword/1 with valid data creates a keyword" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Keyword{} = keyword} = Keywords.create_keyword(valid_attrs)
      assert keyword.name == "some name"
    end

    test "create_keyword/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Keywords.create_keyword(@invalid_attrs)
    end

    test "update_keyword/2 with valid data updates the keyword" do
      keyword = keyword_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Keyword{} = keyword} = Keywords.update_keyword(keyword, update_attrs)
      assert keyword.name == "some updated name"
    end

    test "update_keyword/2 with invalid data returns error changeset" do
      keyword = keyword_fixture()
      assert {:error, %Ecto.Changeset{}} = Keywords.update_keyword(keyword, @invalid_attrs)
      assert keyword == Keywords.get_keyword!(keyword.id)
    end

    test "delete_keyword/1 deletes the keyword" do
      keyword = keyword_fixture()
      assert {:ok, %Keyword{}} = Keywords.delete_keyword(keyword)
      assert_raise Ecto.NoResultsError, fn -> Keywords.get_keyword!(keyword.id) end
    end

    test "change_keyword/1 returns a keyword changeset" do
      keyword = keyword_fixture()
      assert %Ecto.Changeset{} = Keywords.change_keyword(keyword)
    end
  end
end
