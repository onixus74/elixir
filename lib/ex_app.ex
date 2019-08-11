defmodule ExApp do
  use Plug.Router
  plug(:match)

  plug(Plug.Parsers,
    parsers: [:json],
    pass: ["application/json"],
    json_decoder: Jason
  )

  plug(:dispatch)

  @moduledoc """
  A simple OMG template for Elixir.
  """

  get "/health" do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, "healthy")
  end

  post "/message" do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Jason.encode!(hello(conn.body_params["name"])))
  end

  defp hello(name), do: %{message: "Hello #{name}"}

  match _ do
    send_resp(conn, 404, "Not found")
  end
end
