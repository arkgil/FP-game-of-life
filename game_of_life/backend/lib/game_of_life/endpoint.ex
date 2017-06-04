defmodule GameOfLife.Endpoint do
  @moduledoc false

  use Phoenix.Endpoint, otp_app: :game_of_life

  socket "/socket", GameOfLife.UserSocket

  plug Plug.Static,
    at: "/", from: :game_of_life, gzip: false,
    only: ~w(css fonts images js favicon.ico robots.txt)

  if code_reloading? do
    socket "/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
  end

  plug Plug.RequestId
  plug Plug.Logger

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head

  plug Plug.Session,
    store: :cookie,
    key: "_cave_key",
    signing_salt: "nTLnds8n"

  plug GameOfLife.Router
end
