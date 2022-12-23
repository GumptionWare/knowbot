defmodule Knowbot.KeywordsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Knowbot.Keywords` context.
  """

  @doc """
  Generate a keyword.
  """
  def keyword_fixture(attrs \\ %{}) do
    {:ok, keyword} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Knowbot.Keywords.create_keyword()

    keyword
  end
end
