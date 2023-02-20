defmodule PentoP2Web.Pento.Shape do
  @moduledoc false
  use Phoenix.Component
  alias PentoP2Web.Pento.Point

  def draw(assigns) do
    ~H"""
      <%= for {x,y} <- @points do %>
        <Point.draw
          x={ x }
          y={ y }
          fill={ @fill }
          name={ @name }
        />
      <% end %>
    """
  end
end
