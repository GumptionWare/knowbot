defmodule Knowbot.Consumer do
  use Nostrum.Consumer

  alias Nostrum.Api

  @help_content ~S"""
  **KnowBot**: Your learning assistant. Like you, I'm getting smarter every day.

  Each command starts with \"**!**\" (the \"bang\" character).
  **!h** or **!help** - Gets you this help content.
  **!q** - Ask a question. EXAMPLES:
         !q How do I use Enum?
         !q Enum?
         !q Enum.filter?
      I start with the **?**. I assume the most important word has the question
      mark after it.
  **!faq** - show the Frequently Asked Questions (FAQs).
  """
  def start_link do
    Consumer.start_link(__MODULE__)
  end

  def handle_event({:MESSAGE_CREATE, msg, _ws_state}) do
    # IO.inspect(msg.content, label: "handle_event")

    case String.downcase(msg.content) do
      "!sleep" ->
        Api.create_message(msg.channel_id, "Going to sleep...")
        # This won't stop other events from being handled.
        Process.sleep(3000)

      "!ping" ->
        Api.create_message(msg.channel_id, "Hello Discord! I am your KnowBot.")

      "!h" ->
        Api.create_message(msg.channel_id, @help_content)

      "!help" ->
        Api.create_message(msg.channel_id, @help_content)

      "!raise" ->
        # This won't crash the entire Consumer.
        raise "No problems here!"

      _ ->
        :ignore
    end
  end

  # Default event handler, if you don't include this, your consumer WILL crash if
  # you don't have a method definition for each event type.
  def handle_event(_event) do
    :noop
  end
end
