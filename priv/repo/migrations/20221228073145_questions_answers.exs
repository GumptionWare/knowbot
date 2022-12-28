defmodule Knowbot.Repo.Migrations.QuestionsAnswers do
  use Ecto.Migration

  # many-to-many associations between Questions and Answers
  def change do
  # Create a new table called 'question_answers'
  create table(:question_answers) do
    # Add a column named 'question_id' with a reference to the 'questions' table
    add(:question_id, references(:questions, on_delete: :delete_all), null: false)
    # Add a column named 'answer_id' with a reference to the 'answers' table
    add(:answer_id, references(:answers, on_delete: :delete_all), null: false)
  end

  # Create a unique index on the 'question_answers' table with the 'question_id' and 'answer_id' columns
  create(unique_index(:question_answers, [:question_id, :answer_id]))
  end
end
