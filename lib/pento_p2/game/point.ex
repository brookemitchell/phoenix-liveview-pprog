defmodule PentoP2.Game.Point do
  @moduledoc """
  Define a point the basis for the five points that efine a shape
  """
  def new(x, y) when is_integer(x) and is_integer(y), do: {x, y}

  def move({x, y}, {change_x, change_y}) do
    {x + change_x, y + change_y}
  end
end
