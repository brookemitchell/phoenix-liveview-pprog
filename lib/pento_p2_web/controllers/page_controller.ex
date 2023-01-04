defmodule PentoP2Web.PageController do
  use PentoP2Web, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
