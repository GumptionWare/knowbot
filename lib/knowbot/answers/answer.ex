defmodule Knowbot.Answers.Answer do
  use Ecto.Schema
  import Ecto.Changeset

  schema "answers" do
    field :answered_by, :string
    field :content, :string

    timestamps()
  end

  @doc false
  def changeset(answer, attrs) do
    answer
    |> cast(attrs, [:content, :answered_by])
    |> validate_required([:content, :answered_by])
  end
end
