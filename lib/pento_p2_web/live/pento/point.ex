defmodule PentoP2Web.Pento.Point do
  @moduledoc false
  use Phoenix.Component

  @width 10

  def draw(assigns) do
    ~H"""
      <use
        xlink:href="#point"
        x={ convert(@x) }
        y={ convert(@y) }
        fill={ @fill }
        phx-click="pick"
        phx-value-name={ @name } />
    """
  end

  defp convert(i) do
    (i - 1) * @width + 2 * @width
  end
end
