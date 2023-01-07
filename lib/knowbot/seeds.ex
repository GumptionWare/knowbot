defmodule Knowbot.Seeds do
  alias Knowbot.Tags
  alias Knowbot.Keywords
  alias Knowbot.Questions
  alias Knowbot.Questions.Question
  alias Knowbot.Answers
  alias Knowbot.Answers.Answer
  alias Knowbot.Keywords
  alias Knowbot.Keywords.Keyword
  alias Knowbot.Tags
  alias Knowbot.Tags.Tag
  alias Knowbot.Repo

  def seed do
    seed_questions()
    seed_answers()
    seed_keywords()
    seed_tags()
  end

  def seed_questions do
    case Repo.get_by(Question, content: "Why is Enum.is_empty not working?") do
      %Question{} = question ->
        IO.inspect(question.content, label: "Question already created.")
      nil ->
        Questions.create_question(%{content: "Why is Enum.is_empty not working?"})
    end
    case Repo.get_by(Question, content: "Will ChatGPT take my job?") do
      %Question{} = question ->
        IO.inspect(question.content, label: "Question already created.")
      nil ->
        Questions.create_question(%{content: "Will ChatGPT take my job?"})
    end
    case Repo.get_by(Question, content: "Is ChatGPT better than using Google?") do
      %Question{} = question ->
        IO.inspect(question.content, label: "Question already created.")
      nil ->
        Questions.create_question(%{content: "Is ChatGPT better than using Google?"})
    end
    case Repo.get_by(Question, content: "How do I use recursion?") do
      %Question{} = question ->
        IO.inspect(question.content, label: "Question already created.")
      nil ->
        Questions.create_question(%{content: "How do I use recursion?"})
    end

  end

  def seed_answers() do
    case Repo.get_by(Answer, content: "The correct function is Enum.empty?(enumerable),
      where `enumerable` is the list you are inspecting.") do
      %Answer{} = answer ->
        IO.inspect(answer.content, label: "Answer already created.")
      nil ->
        question = Repo.get_by(Question, content: "Why is Enum.is_empty not working?")
        IO.inspect(question.id, label: "Question ID")
        IO.inspect(question, label: "Question")
        Answers.create_answer(%{content: "The correct function is Enum.empty?(enumerable),
        where `enumerable` is the list you are inspecting.", questions: question})
    end
  end

  # Create tags
  def seed_tags() do
    ["ChatGPT", "Enum", "String", "List"]
    |> Enum.each(fn tag_name ->
      case Repo.get_by(Tag, name: tag_name) do
        %Tag{} = tag ->
          IO.inspect(tag.name, label: "Tag already created")
        nil ->
          Tags.create_tag(%{name: tag_name})
      end
    end)
  end

  # Create keywords
  def seed_keywords() do
    ["recursion", "sorting", "API", "AI"]
    |> Enum.each(fn keyword_name ->
      case Repo.get_by(Keyword, name: keyword_name) do
        %Keyword{} = keyword ->
          IO.inspect(keyword.name, label: "Keyword already created")
        nil ->
          Keywords.create_keyword(%{name: keyword_name})
      end
    end)
  end

end
