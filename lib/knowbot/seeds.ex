defmodule Knowbot.Seeds do
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
  # Seed Answers: In this case, we will answer questions asked above
  def seed_answers() do
    # First Answer
    {:ok, answer} =
      case Repo.get_by(Answer, content: "The correct function is Enum.empty?(enumerable),where `enumerable` is the list you are inspecting.") do
        %Answer{} = answer ->
          IO.inspect(answer.content, label: "Answer already created.")
          {:ok, answer}

        nil ->
          Answers.create_answer(%{content: "The correct function is Enum.empty?(enumerable), where `enumerable` is the list you are inspecting.",
          answered_by: "JSH"})
        end

    case Repo.get_by(Question, content: "Why is Enum.is_empty not working?") do
      %Question{} = question ->
        # This is what we want, so:
        # Answers.update_answer(answer, %{id: answer.id, content: answer.content}, [question])
        Answers.update_answer(answer, %{id: answer.id, content: answer.content}, [question])

      nil ->
        IO.inspect(answer.content, label: "ERROR ... We should have this question.")
    end
    # Second Answer
    {:ok, answer} =
      case Repo.get_by(Answer, content: "Only if you let it. ChatGPT is a tool. Despite the impression is gives you that it is thinking, it is not. It does, however, give you compelling answers with lots of confidence--but that's the rub. It doesn't know when it is wrong, so it will confidently give you wrong answers all day.") do
        %Answer{} = answer ->
          IO.inspect(answer.content, label: "Answer already created.")
          {:ok, answer}

        nil ->
          Answers.create_answer(%{content: "Only if you let it. ChatGPT is a tool. Despite the impression is gives you that it is thinking, it is not. It does, however, give you compelling answers with lots of confidence--but that's the rub. It doesn't know when it is wrong, so it will confidently give you wrong answers all day.", answered_by: "JSH"})
        end

    case Repo.get_by(Question, content: "Will ChatGPT take my job?") do
      %Question{} = question ->
        # This is what we want, so:
        Answers.update_answer(answer, %{id: answer.id, content: answer.content}, [question])

      nil ->
        IO.inspect(answer.content, label: "ERROR ... We should have this question.")
    end
    # Third Answer
    {:ok, answer} =
      case Repo.get_by(Answer, content: "In Elixir, recursion is used to repeatedly call a function until a certain condition is met. Here is an example of a recursive function that calculates the factorial of a given number:
      `defmodule Factorial do
        def factorial(0), do: 1
        def factorial(n) when n > 0, do: n * factorial(n-1)
      end`
      In this example, the function factorial/1 takes one argument and has two function clauses. The first clause, factorial(0), is the base case and returns the value 1. The second clause, factorial(n) when n > 0, is the recursive case and calls itself with the argument n-1. This will be repeated until the argument is 0, at which point the base case will be reached and the function will return the final result.
You can call this function by running Factorial.factorial(5) for example, it will return the factorial of 5 which is 120.
It's important to note that in some cases, using recursion can lead to stack overflow, so it's important to be mindful of the recursion depth and to have a base case that guarantees the recursion will eventually stop.") do
        %Answer{} = answer ->
          IO.inspect(answer.content, label: "Answer already created.")
          {:ok, answer}

        nil ->
          Answers.create_answer(%{content: "In Elixir, recursion is used to repeatedly call a function until a certain condition is met. Here is an example of a recursive function that calculates the factorial of a given number:
          `defmodule Factorial do
            def factorial(0), do: 1
            def factorial(n) when n > 0, do: n * factorial(n-1)
          end`
          In this example, the function factorial/1 takes one argument and has two function clauses. The first clause, factorial(0), is the base case and returns the value 1. The second clause, factorial(n) when n > 0, is the recursive case and calls itself with the argument n-1. This will be repeated until the argument is 0, at which point the base case will be reached and the function will return the final result.
You can call this function by running Factorial.factorial(5) for example, it will return the factorial of 5 which is 120.
It's important to note that in some cases, using recursion can lead to stack overflow, so it's important to be mindful of the recursion depth and to have a base case that guarantees the recursion will eventually stop.", answered_by: "JSH"})
        end

    case Repo.get_by(Question, content: "How do I use recursion?") do
      %Question{} = question ->
        # This is what we want, so:
        Answers.update_answer(answer, %{id: answer.id, content: answer.content}, [question])

      nil ->
        IO.inspect(answer.content, label: "ERROR ... We should have this question.")
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
