defmodule Knowbot.Consumer do
  use Nostrum.Consumer

  alias Nostrum.Api
  alias Knowbot.Questions.Question
  alias Knowbot.Repo
  alias Nostrum.Struct.Component.ActionRow
  alias Nostrum.Struct.Component.Button

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

  # ready event handler
  def handle_event({:READY, ready, _ws_state}) do
    # IO.inspect(ready)
    # TO DO: Add the command creation logic here

  end

  # gateway event handler to process slash commands:
  def handle_event({:INTERACTION_CREATE, interaction, _ws_state}) do
    # IO.inspect(interaction)
    invoked_command = interaction.data.name
    IO.inspect(invoked_command)
    # TO DO: Stop using String.to_atom here ... DANGEROUS
    response_message = apply(__MODULE__, String.to_atom(invoked_command), [])
    da_button = ActionRow.action_row()
    |> ActionRow.append(Button.link_button("Best Movie Ever Made", "https://www.imdb.com/title/tt0118880/?ref=fn_al_tt_1"))
    response = %{
      type: 4,  # ChannelMessageWithSource
      data: %{
        content: response_message,
        components: [da_button]
        # components: [Nostrum.Struct.Component.Button.interaction_button("Answer", 42)]

      }
    }
    Api.create_interaction_response(interaction, response)
  end

  def handle_event({:MESSAGE_CREATE, msg, _ws_state}) do
    # IO.inspect(msg.content, label: "handle_event")
    msg_content = msg.content
    # case String.downcase(msg.content) do
    cond do
      String.starts_with?(String.downcase(msg_content), "!q") ->
        # Api.create_message(msg.channel_id, "DEBUG: #{msg_content}")
        # HACK (v1): Create the question record directly here
        # *** This should really be via API interactions *** (TO-DO)
        question_content =
          msg_content
          |> String.trim_leading("!q")
          |> String.trim_leading("!Q")
          |> String.trim_leading()

          question = Question.changeset(%Question{}, %{content: question_content})
          # If no errors, insert the question into the DB:
          if Enum.empty?(question.errors) do
            Repo.insert!(question)
            Api.create_message(msg.channel_id, "Your question has been recorded. Aloha.")
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

      String.downcase(msg_content) == "!h" ->
        Api.create_message(msg.channel_id, @help_content)
      #   user = userManager.GetCurrentUser()
      #   Console.WriteLine("Connected to user {0}", user.Id);

      String.downcase(msg_content) == "!help" ->
        Api.create_message(msg.channel_id, @help_content)

      String.downcase(msg_content) == "!sleep" ->
        Api.create_message(msg.channel_id, "Going to sleep...")
        # This won't stop other events from being handled.
        Process.sleep(3000)

      String.downcase(msg_content) == "!ping" ->
        Api.create_message(msg.channel_id, "Hello DY Academy! I am your KnowBot, your learning assistant.")

      String.downcase(msg_content) == "!raise" ->
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

  def faq do
    "FAQ coming REAL soon"
  end

  def question do
    "Questions coming REAL soon"
  end

  def answer do
    "Something TOTALLY different"
    # Nostrum.Struct.Component.Button.interaction_button("Answer", 42)
  end
  def help do
    @help_content
  end

end
