defmodule Knowbot.QuestionsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Knowbot.Questions` context.
  """

  @doc """
  Generate a question.
  """
  def question_fixture(attrs \\ %{}) do
    {:ok, question} =
      attrs
      |> Enum.into(%{
        asker: "some asker",
        content: "some content"
      })
      |> Knowbot.Questions.create_question()

    question
  end
end
