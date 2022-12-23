defmodule Knowbot.QuestionsTest do
  use Knowbot.DataCase

  alias Knowbot.Questions

  describe "questions" do
    alias Knowbot.Questions.Question

    import Knowbot.QuestionsFixtures

    @invalid_attrs %{asker: nil, content: nil}

    test "list_questions/0 returns all questions" do
      question = question_fixture()
      assert Questions.list_questions() == [question]
    end

    test "get_question!/1 returns the question with given id" do
      question = question_fixture()
      assert Questions.get_question!(question.id) == question
    end

    test "create_question/1 with valid data creates a question" do
      valid_attrs = %{asker: "some asker", content: "some content"}

      assert {:ok, %Question{} = question} = Questions.create_question(valid_attrs)
      assert question.asker == "some asker"
      assert question.content == "some content"
    end

    test "create_question/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Questions.create_question(@invalid_attrs)
    end

    test "update_question/2 with valid data updates the question" do
      question = question_fixture()
      update_attrs = %{asker: "some updated asker", content: "some updated content"}

      assert {:ok, %Question{} = question} = Questions.update_question(question, update_attrs)
      assert question.asker == "some updated asker"
      assert question.content == "some updated content"
    end

    test "update_question/2 with invalid data returns error changeset" do
      question = question_fixture()
      assert {:error, %Ecto.Changeset{}} = Questions.update_question(question, @invalid_attrs)
      assert question == Questions.get_question!(question.id)
    end

    test "delete_question/1 deletes the question" do
      question = question_fixture()
      assert {:ok, %Question{}} = Questions.delete_question(question)
      assert_raise Ecto.NoResultsError, fn -> Questions.get_question!(question.id) end
    end

    test "change_question/1 returns a question changeset" do
      question = question_fixture()
      assert %Ecto.Changeset{} = Questions.change_question(question)
    end
  end
end
