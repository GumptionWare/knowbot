defmodule Knowbot.AnswersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Knowbot.Answers` context.
  """

  @doc """
  Generate a answer.
  """
  def answer_fixture(attrs \\ %{}) do
    {:ok, answer} =
      attrs
      |> Enum.into(%{
        answered_by: "some answered_by",
        content: "some content"
      })
      |> Knowbot.Answers.create_answer()

    answer
  end
end
