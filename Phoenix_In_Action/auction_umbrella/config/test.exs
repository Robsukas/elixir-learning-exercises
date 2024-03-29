import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :auction_web, AuctionWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "gGgPktitSgGE5y7Ilq4iFoX6IwIiR0rcRlbPgP+kqA0rXcoSBKSnuc3SL+cQ4OMc",
  server: false

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :auction_web, AuctionWebWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "euBUj33wfy/6kCwUFZT51at1roetEcCivqhudBMoLBza93ek0Ki+IO0vQ0mXDA3Z",
  server: false

# In test we don't send emails.
config :auction_web, AuctionWeb.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
