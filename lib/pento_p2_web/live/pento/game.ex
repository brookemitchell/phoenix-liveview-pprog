defmodule PentoP2Web.Pento.GameLive do
  @moduledoc false
  use PentoP2Web, :live_view
  alias PentoP2Web.Pento.{Board}

  def mount(%{"puzzle" => puzzle}, _session, socket) do
    {:ok, assign(socket, puzzle: puzzle)}
  end

  def render(assigns) do
    ~H"""
      <section class="container">
        <h1>Welcome to Pento!</h1>
        <.live_component module={Board} puzzle={@puzzle} id="game" />
      </section>
    """
  end
end
