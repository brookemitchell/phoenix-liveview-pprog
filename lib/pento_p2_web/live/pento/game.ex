defmodule PentoP2Web.Pento.GameLive do
  @moduledoc false
  use PentoP2Web, :live_view
  alias PentoP2Web.Pento.{Canvas, Point}

  def mount(_params, _session, socket), do: {:ok, socket}

  def render(assigns) do
    ~H"""
      <section class="container">
        <h1>Welcome to Pento!</h1>
      </section>
      <Canvas.draw viewBox="0 0 100 100" >
        <Point.draw x={0} y={0} fill="blue" name="a"/>
        <Point.draw x={1} y={0} fill="green" name="b"/>
        <Point.draw x={0} y={1} fill="red" name="c"/>
        <Point.draw x={1} y={1} fill="black" name="d"/>
      </Canvas.draw>
    """
  end
end
