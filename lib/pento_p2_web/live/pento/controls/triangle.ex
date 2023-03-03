defmodule PentoP2Web.Pento.Controls.Triangle do
  @moduledoc false
  use Phoenix.Component

  def draw(assigns) do
    ~H"""
      <use
        x={ @x }
        y={ @y }
        transform={"rotate(#{@rotate}, 5, 5)"}
        href="#triangle"
        fill={ @fill } />
    """
  end
end
