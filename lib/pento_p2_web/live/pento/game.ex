defmodule PentoP2Web.Pento.GameLive do
  @moduledoc false
  use PentoP2Web, :live_view
  alias PentoP2Web.Pento.{Board, ControlPanel, Controls, Instructions}

  def mount(%{"puzzle" => puzzle}, _session, socket) do
    {:ok, assign(socket, puzzle: puzzle)}
  end

  def render(assigns) do
    ~H"""
      <section class="container">
        <Instructions.show />
        <ControlPanel.draw viewBox="0 0 200 100" >
          <g transform={"translate(20 20)"}>
            <Controls.Triangle.draw rotate="0" fill="green" x="-2" y="-12"/>
            <Controls.Triangle.draw rotate="270" fill="pink" x="-4" y="-16"/>
            <Controls.Triangle.draw rotate="90" fill="red" x="1" y="-15" />
            <Controls.Triangle.draw rotate="180" fill="blue" x="-.5" y="-17"/>
          </g>
        </ControlPanel.draw>
        <%!-- @puzzle to determine size from route --%>
        <.live_component module={Board} id="game" puzzle={@puzzle}  />
      </section>
    """
  end
end
