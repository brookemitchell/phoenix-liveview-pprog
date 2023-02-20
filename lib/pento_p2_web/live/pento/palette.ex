defmodule PentoP2Web.Pento.Palette do
  @moduledoc false
  use Phoenix.Component
  alias PentoP2Web.Pento.{Shape, Canvas}
  alias PentoP2.Game.Pentomino
  import PentoP2Web.Pento.Colors

  def draw(assigns) do
    shapes =
      assigns.shape_names
      |> Enum.with_index()
      |> Enum.map(&pentomino/1)

    assigns = assign(assigns, shapes: shapes)

    IO.inspect(assigns)

    ~H"""
      <div id="palette">
        <Canvas.draw viewBox="0 0 500 125" >
          <%= for shape <- @shapes do %>
            <Shape.draw
              points={ shape.points }
              fill={ color(shape.color) }
              name={ shape.name }
            />

          <% end %>


        </Canvas.draw>
      </div>
    """
  end

  defp pentomino({name, i}) do
    {x, y} = {rem(i, 6) * 4 + 3, div(i, 6) * 5 + 3}

    Pentomino.new(name: name, location: {x, y})
    |> Pentomino.to_shape()
  end
end
