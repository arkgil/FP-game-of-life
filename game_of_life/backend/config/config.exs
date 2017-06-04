use Mix.Config

config :game_of_life, GameOfLife.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "BpKTW4MB81+Q4SQol/ILpoRIZX+9fArTeYGTtQ8ffcBOl4pxSxjrzkrrPlcUAXhy",
  render_errors: [view: GameOfLife.ErrorView, accepts: ~w(html json)],
  pubsub: [name: GameOfLife.PubSub,
           adapter: Phoenix.PubSub.PG2]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

import_config "#{Mix.env}.exs"
