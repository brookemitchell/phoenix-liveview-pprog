defmodule PentoP2.Survey.Demographic do
  use Ecto.Schema
  import Ecto.Changeset
  alias PentoP2.Accounts.User

  schema "demographics" do
    field :gender, :string
    field :year_of_birth, :integer
    field :education_level, :string
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(demographic, attrs) do
    demographic
    |> cast(attrs, [:gender, :year_of_birth, :user_id])
    |> validate_required([:gender, :year_of_birth, :user_id])
    |> validate_inclusion(:gender, ["male", "female", "other", "prefer not to say"])
    |> validate_inclusion(:year_of_birth, 1900..2022)
    |> validate_inclusion(:education_level, [
      "bachelor's degree",
      "graduate degree",
      "high school",
      "other",
      "prefer not to say"
    ])
    |> unique_constraint(:user_id)
  end
end
