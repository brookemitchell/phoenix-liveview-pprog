defmodule PentoP2Web.Pento.GameLive do
  @moduledoc false
  use PentoP2Web, :live_view

  def mount(_params, _session, socket), do: {:ok, socket}

  def render(assigns) do
    ~H"""
      <section class="container">
        <h1>Welcome to Pento!</h1>
      </section>
      <svg viewBox="0 0 100 100">
        <rect x="0" y="0" width="10" height="10" />
      </svg>
    """
  end
end
