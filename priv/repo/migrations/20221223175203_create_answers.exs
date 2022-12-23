defmodule Knowbot.Repo.Migrations.CreateAnswers do
  use Ecto.Migration

  def change do
    create table(:answers) do
      add :content, :text
      add :answered_by, :string

      timestamps()
    end
  end
end
