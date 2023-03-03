defmodule PentoP2Web.Pento.ControlPanel do
  @moduledoc false
  use Phoenix.Component

  def draw(assigns) do
    ~H"""
      <svg viewBox={ @viewBox }>
        <defs>
          <polygon id="triangle" points="6.25 1.875, 12.5 12.5, 0 12.5" />
        </defs>
        <g>
          <%= render_slot(@inner_block) %>
        </g>
      </svg>
    """
  end
end
