defmodule PentoP2.Game.Pentomino do
  @moduledoc false
  alias PentoP2.Game.Shape
  alias PentoP2.Game.Point
  @names [:i, :l, :y, :n, :p, :w, :u, :v, :s, :f, :x, :t]
  @default_location {8, 8}

  defstruct name: :i,
            rotation: 0,
            reflected: false,
            location: @default_location

  def new(fields \\ []), do: __struct__(fields)

  def rotate(%{rotation: degrees} = p, opts \\ []) do
    mult =
      case Keyword.get(opts, :direction, :clockwise) do
        :anti_clockwise -> -1
        :clockwise -> 1
      end

    %{p | rotation: rem(degrees + 90 * mult, 360)}
  end

  def flip(%{reflect: reflection} = p), do: %{p | reflected: not reflection}

  @spec up(%{:location => {number, number}, optional(any) => any}) :: %{
          :location => {number, number},
          optional(any) => any
        }
  def up(p), do: %{p | location: Point.move(p.location, {0, -1})}
  def down(p), do: %{p | location: Point.move(p.location, {0, 1})}
  def left(p), do: %{p | location: Point.move(p.location, {-1, 0})}
  def right(p), do: %{p | location: Point.move(p.location, {1, 0})}

  def to_shape(pento) do
    Shape.new(pento.name, pento.rotation, pento.reflected, pento.location)
  end

  def overlapping?(pento1, pento2) do
    {p1, p2} = {to_shape(pento1).points, to_shape(pento2).points}
    Enum.count(p1 -- p2) != 5
  end
end
