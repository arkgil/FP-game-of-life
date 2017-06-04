use Mix.Config

config :game_of_life, GameOfLife.Endpoint,
  http: [port: 4001],
  server: false

config :logger, level: :warn
