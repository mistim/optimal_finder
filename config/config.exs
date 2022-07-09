# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of the Config module.
#
# Note that all applications in your umbrella share the
# same configuration and dependencies, which is why they
# all use the same configuration file. If you want different
# configurations or dependencies per app, it is best to
# move said applications out of the umbrella.
import Config

# Configure Mix tasks and generators
config :admin,
  ecto_repos: [Admin.Repo]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :admin, Admin.Mailer, adapter: Swoosh.Adapters.Local

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

config :admin_web,
  ecto_repos: [AdminWeb.Repo],
  generators: [context_app: false]

# Configures the endpoint
config :admin_web, AdminWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: AdminWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: AdminWeb.PubSub,
  live_view: [signing_salt: "cv2D7uTB"]

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.14.29",
  admin: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../apps/admin_web/assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configure Mix tasks and generators
config :optimal_finder,
  ecto_repos: [OptimalFinder.Repo]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :optimal_finder, OptimalFinder.Mailer, adapter: Swoosh.Adapters.Local

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

config :optimal_finder_web,
  ecto_repos: [OptimalFinder.Repo],
  generators: [context_app: :optimal_finder]

# Configures the endpoint
config :optimal_finder_web, OptimalFinderWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: OptimalFinderWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: OptimalFinder.PubSub,
  live_view: [signing_salt: "csi8KQQ2"]

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.14.29",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../apps/optimal_finder_web/assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
