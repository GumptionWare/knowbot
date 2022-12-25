defmodule Knowbot.Questions.Question do
  use Ecto.Schema
  import Ecto.Changeset

  schema "questions" do
    field :asker, :string
    field :content, :string

    timestamps()
  end

  @doc false
  def changeset(question, attrs) do
    question
    |> cast(attrs, [:content, :asker])
    |> validate_required([:content]) # , :asker #... later
  end
end
