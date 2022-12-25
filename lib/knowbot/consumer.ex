defmodule Knowbot.Consumer do
  use Nostrum.Consumer

  alias Nostrum.Api
  alias Knowbot.Questions.Question
  alias Knowbot.Repo
  import String

  @help_content ~S"""
  **KnowBot**: Your learning assistant. Like you, I'm getting smarter every day.

  Each command starts with \"**!**\" (the \"bang\" character [shift-1]).
  **!h** or **!help** - Gets you this help content.
  **!q** - Ask a question. EXAMPLES:
         !q How do I use Enum?
         !q Enum?
         !q Enum.filter?
      I start with the **?**. I assume the most important word has the question mark after it.
  **!faq** - show the Frequently Asked Questions (FAQs).
  """
  def start_link do
    Consumer.start_link(__MODULE__)
  end

  def handle_event({:MESSAGE_CREATE, msg, _ws_state}) do
    # IO.inspect(msg.content, label: "handle_event")
    msg_content = msg.content
    # case String.downcase(msg.content) do
    cond do
      String.starts_with?(msg_content, "!q") ->
        Api.create_message(msg.channel_id, "DEBUG: #{msg_content}")
        # HACK (v1): Create the question record directly here
        # *** This should really be via API interactions *** (TO-DO)
        question_content =
          msg_content
          |> String.trim_leading("!q")
          |> String.trim_leading()

          question = Question.changeset(%Question{}, %{content: question_content})
          # IO.inspect(question)
          # If no errors, insert the question into the DB:
          if Enum.empty?(question.errors) do
            Repo.insert!(question)
            Api.create_message(msg.channel_id, "Your message has been recorded. Aloha.")
          else
            Api.create_message(msg.channel_id, "Whoops! We had a problem recording your question, but we are working on a solution.")
          end

          # LATER: When we search for similar questions already answered ...
          #     msg_content = String.downcase(msg.content)
          # ... then, something like ...
          # ... find the part prior to the '?' is search_phrase
          #   search_term =
          #     msg_content
          #     |> String.split
          #     |> Enum.filter(fn word -> String.ends_with?(word, "?") end)
          #     |> List.first
          #     |> String.trim_trailing("?")
          #   # search_results = search_by(search_term)
          #   |> Api.create_message(msg.channel_id)

      msg_content == "!h" ->
        Api.create_message(msg.channel_id, @help_content)
      #   user = userManager.GetCurrentUser()
      #   Console.WriteLine("Connected to user {0}", user.Id);

      msg_content == "!help" ->
        Api.create_message(msg.channel_id, @help_content)

      msg_content == "!sleep" ->
        Api.create_message(msg.channel_id, "Going to sleep...")
        # This won't stop other events from being handled.
        Process.sleep(3000)

      msg_content == "!ping" ->
        Api.create_message(msg.channel_id, "Hello DY Academy! I am your KnowBot, your learning assistant.")

      msg_content == "!raise" ->
        # This won't crash the entire Consumer.
        raise "No problems here!"

      true ->
        :ignore
    end
  end

  # Default event handler, if you don't include this, your consumer WILL crash if
  # you don't have a method definition for each event type.
  def handle_event(_event) do
    :noop
  end
end
