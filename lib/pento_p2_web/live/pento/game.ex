defmodule PentoP2Web.Pento.GameLive do
  @moduledoc false
  use PentoP2Web, :live_view
  alias PentoP2Web.Pento.{Canvas, Shape}

  def mount(_params, _session, socket), do: {:ok, socket}

  def render(assigns) do
    ~H"""
      <section class="container">
        <h1>Welcome to Pento!</h1>
      </section>
      <Canvas.draw viewBox="0 0 200 70" >
        <Shape.draw
          fill="orange"
          name="p"
          points={ [ {3,2}, {4,3}, {3,3}, {4,2}, {3,4} ] } />
      </Canvas.draw>
    """
  end
end
