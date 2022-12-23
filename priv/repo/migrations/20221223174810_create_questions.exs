defmodule Knowbot.Repo.Migrations.CreateQuestions do
  use Ecto.Migration

  def change do
    create table(:questions) do
      add :content, :text
      add :asker, :string

      timestamps()
    end
  end
end
