defmodule PentoP2Web.Pento.Board do
  @moduledoc false
  use PentoP2Web, :live_component
  alias PentoP2Web.Pento.{Canvas, Palette, Shape}
  alias PentoP2.Game.{Board, Pentomino}
  import PentoP2Web.Pento.Colors

  def update(%{id: id, puzzle: puzzle}, socket) do
    {:ok,
     socket
     |> assign_params(id, puzzle)
     |> assign_board()
     |> assign_shapes()}
  end

  def handle_event("key", _, socket) do
    {:noreply, socket}
  end

  def assign_params(socket, id, puzzle) do
    assign(socket, id: id, puzzle: puzzle)
  end

  def assign_board(%{assigns: %{puzzle: puzzle}} = socket) do
    active = Pentomino.new(name: :i, location: {3, 2})

    completed = [
      Pentomino.new(name: :u, rotation: 270, location: {1, 2}),
      Pentomino.new(name: :v, rotation: 90, location: {4, 2})
    ]

    board =
      puzzle
      |> String.to_existing_atom()
      |> Board.new()
      |> Map.put(:completed_pentos, completed)
      |> Map.put(:active_pento, active)

    assign(socket, board: board)
  end

  def assign_shapes(%{assigns: %{board: board}} = socket) do
    shape = Board.to_shape(board)
    assign(socket, shapes: [shape])
  end

  def render(assigns) do
    ~H"""
      <div id={ @id } phx-window-keydown="key" phx-target={@myself} >
        <Canvas.draw viewBox="0 0 200 70" >
          <%= for shape <- @shapes do %>
            <Shape.draw
              points={shape.points}
              fill={color(shape.color, Board.active?(@board, shape.name))}
              name={shape.name} />
          <% end %>
        </Canvas.draw>
        <hr/>
        <Palette.draw
          id="palette"
          shape_names={@board.palette} />
      </div>

    """
  end
end
