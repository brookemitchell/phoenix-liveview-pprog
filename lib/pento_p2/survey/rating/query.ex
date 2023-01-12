defmodule PentoP2.Survey.Rating.Query do
  import Ecto.Query
  alias PentoP2.Survey.Rating

  def base, do: Rating

  def preload_user(user) do
    base()
    |> for_user(user)
  end

  def for_user(query \\ base(), user) do
    query
    |> where([r], r.user_id == ^user.id)
  end
end
