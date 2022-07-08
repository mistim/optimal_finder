import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :admin_web, AdminWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "N1ntN9WDecND51n9TyYaszJjNVGI1vrrK9pPxkwClNplDeMtZzIyhRM3gFIfy9Cd",
  server: false

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :optimal_finder, OptimalFinder.Repo,
  username: "root",
  password: "",
  hostname: "localhost",
  database: "optimal_finder_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :optimal_finder_web, OptimalFinderWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "FDL/O8Tg6sqEmo23jCK+4H/bk1HaFGNU9nB+IPSKy5s9basbzkZXEQ3BTypqiqIQ",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# In test we don't send emails.
config :optimal_finder, OptimalFinder.Mailer, adapter: Swoosh.Adapters.Test

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
