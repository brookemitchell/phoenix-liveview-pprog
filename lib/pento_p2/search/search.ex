# repo-less changeset
defmodule PentoP2.Search do
  defstruct sku: nil
  @type t :: %__MODULE__{sku: String.t()}
  @types %{sku: :string}

  import Ecto.Changeset

  def changeset(%__MODULE__{} = search, attrs \\ %{}) do
    {search, @types}
    |> cast(attrs, Map.keys(@types))
    |> validate_required(:sku)
    |> validate_length(:sku, is: 7)
    |> validate_format(:sku, ~r/\d{7}/)
  end

  def change_search(%__MODULE__{} = search, attrs \\ %{}) do
    changeset(search, attrs)
  end
end
