defmodule Knowbot.Questions.Question do
  use Ecto.Schema
  import Ecto.Changeset

  schema "questions" do
    field :asker, :string
    field :content, :string
    # Add a many-to-many relationship with the 'answers' table through the
    # 'questions_answers' join table
    many_to_many :answers, Knowbot.Answers.Answer, join_through: "questions_answers", on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(question, attrs, answers \\ []) do
    question
    |> cast(attrs, [:content, :asker])
    |> put_assoc(:answers, answers )
    |> validate_required([:content]) # , :asker #... later
  end
end
