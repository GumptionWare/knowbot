import Config
# Dotenvy:
import Dotenvy

source!([".env", System.get_env()]) # Dotenvy(?)

# Discord bot config:
config :nostrum,
  token: System.get_env("NOSTRUM_TOKEN"),
  gateway_intents: [:guild_messages, :guilds, :message_content]

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :knowbot, Knowbot.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "knowbot_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :knowbot, KnowbotWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "M3l269Gt69VUVuPsG8ib1L1PgaXTGn+uo7c2a1T+JK0I9oZux7TbAKJh4u2yhGju",
  server: false

# In test we don't send emails.
config :knowbot, Knowbot.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
