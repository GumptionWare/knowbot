defmodule Knowbot.AnswersTest do
  use Knowbot.DataCase
  alias Knowbot.Answers

  describe "answers" do
    alias Knowbot.Answers.Answer
    import Knowbot.AnswersFixtures
    import Knowbot.QuestionsFixtures

    @invalid_attrs %{answered_by: nil, content: nil}

    test "list_answers/0 returns all answers" do
      answer = answer_fixture()
      assert Answers.list_answers() == [answer]
    end

    test "get_answer!/1 returns the answer with given id" do
      answer = answer_fixture()
      assert Answers.get_answer!(answer.id) == answer
    end

    test "create_answer/1 with valid data creates a answer" do
      valid_attrs = %{answered_by: "some answered_by", content: "some content"}

      assert {:ok, %Answer{} = answer} = Answers.create_answer(valid_attrs)
      assert answer.answered_by == "some answered_by"
      assert answer.content == "some content"
    end

    test "create_answer/1 with associated question" do
      question = question_fixture()
      valid_attrs = %{answered_by: "some answered_by", content: "some content"}

      assert {:ok, %Answer{} = answer} = Answers.create_answer(valid_attrs, [question] )
      assert answer.answered_by == "some answered_by"
      assert answer.content == "some content"
      assert answer.questions == [question]
    end

    test "create_answer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Answers.create_answer(@invalid_attrs)
    end

    test "update_answer/2 with valid data updates the answer" do
      answer = answer_fixture()
      update_attrs = %{answered_by: "some updated answered_by", content: "some updated content"}

      assert {:ok, %Answer{} = answer} = Answers.update_answer(answer, update_attrs)
      assert answer.answered_by == "some updated answered_by"
      assert answer.content == "some updated content"
    end

    test "update_answer/2 with invalid data returns error changeset" do
      answer = answer_fixture()
      assert {:error, %Ecto.Changeset{}} = Answers.update_answer(answer, @invalid_attrs)
      assert answer == Answers.get_answer!(answer.id)
    end

    test "update answer/3 by associating with a question creates an association as expected" do
      answer = answer_fixture()
      question = question_fixture()
      update_attrs = %{answered_by: "some updated answered_by", content: "some updated content"}
      assert {:ok, %Answer{} = answer} = Answers.update_answer(answer, update_attrs, [question])
    end

    test "delete_answer/1 deletes the answer" do
      answer = answer_fixture()
      assert {:ok, %Answer{}} = Answers.delete_answer(answer)
      assert_raise Ecto.NoResultsError, fn -> Answers.get_answer!(answer.id) end
    end

    test "change_answer/1 returns a answer changeset" do
      answer = answer_fixture()
      assert %Ecto.Changeset{} = Answers.change_answer(answer)
    end
  end
end
