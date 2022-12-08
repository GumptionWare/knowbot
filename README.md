# KnowBot

Discord bot to provide progressively intelligent assistance to Elixir/Phoenix learners participating in the DockYard Academy.

## Vision

Ultimately, KnowBot should be able to "listen in" on conversations in DockYard Academy text channels and provide answers to the questions being asked in the conversations. This involves natural language processing (NLP) functionality that is beyond the scope of an initial release (MVP -- or "MVB" in this case).

## MVB (Minimal Viable Bot) Functionality

Initial functionality is basic: Help (how to use the bot), FAQ (initially, a list of what KnowBot knows), and asking a question, along with rudimentary adminsitration (some sort of curation of KnowBot's knowledge).

## Tentative Roadmap
  ### V1 (01/13/2023): **MVB** (Minimum Viable Bot)
  Time-boxed to create as much value for Academy participants and staff as possible by 12/31/2022. 
  *NOTE*: "!" will be used to invoke commands in the MVB. Later releases will support "/" (slash) commands.

  * __Help__ !H (or help or HELP): How to use the bot. - *DONE*.
  * **FAQ** !faq (or !FAQ) - Growing list of topics already answered/pre-curated in anticipation of most frequently needed information. *This will evolve constantly.*
  * **Ask a question** !q (or !Q): THE core functionality. 
    * Initial Scope: Use the word immediately prior to the question mark as the answer lookup key. *Examples*:
      * "!q how do I sort?"     ==> KnowBot shows information about sort(ing)
      * "!q how do I use Enum?  ==> KnowBot shows information about Enum (the most common functions)
      * "!q Define the universe ==> KnowBot kicks the user from the guild (kidding ...)
  * **Academy Staff Notifications**: Ping a list of Academy teachers/mentors/TAs

  ### V2 (03/01/2023): **Cluetrain**
  Features will be prioritized by balancing the need for pain-relief from paying down technical debt against the urgency and value of user suggestions by Academy members and instructors. Anticipated feature sets (obviously a guess at this point):

  * **Database**: Persist data in Postgres rather than data structure embedded in code and/or the file system.
  * **Attendance**: If possible, track attendance in voice sessions.
  * **Auto-pairing**: See "queue bot" issue/story. 
  * More **robust question parsing** ... edging toward NLP
  * **Curation**: Make it easier for Academy instructors to refine and select content for the growing library of answers (and questions).

  ### V3 (04/01/2023): **Bring on the (AI) monkeys?**
  The "next level" of refinement *could be* to use machine learning (or maybe ChatGPT?) to automate the **curation** of the Q & A library. 
  
  Alternatively, we could keep this curation process *manual*, perhaps encouraging Academy students to engage in the curation process to reinforce their understanding of the material. 
## Background Material about Bots/Discord Bots
A growing list of advice about making the most effective bots:
  * IBM "best practices" article: https://www.ibm.com/cloud/blog/chatbot-best-practices
  * Some person's take on Discord bot best practices: https://github.com/meew0/discord-bot-best-practices
  * Nostrum docs: https://kraigie.github.io/nostrum/intro.html

