defmodule Knowbot.Answers.Answer do
  use Ecto.Schema # Use the Ecto.Schema module to define a schema for 'Answers' table
  import Ecto.Changeset

  schema "answers" do
    field :answered_by, :string
    field :content, :string
    # Add a many-to-many relationship with the 'questions' table through the
    # 'questions_answers' join table
    many_to_many :questions, Knowbot.Questions.Question, join_through: "questions_answers", on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(answer, attrs, questions \\ []) do
    answer
    |> cast(attrs, [:content, :answered_by])
    |> validate_required([:content, :answered_by])
    |> put_assoc(:questions, questions)
  end

end
