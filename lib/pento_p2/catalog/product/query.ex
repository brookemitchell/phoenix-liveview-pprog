defmodule PentoP2.Catalog.Product.Query do
  import Ecto.Query

  alias PentoP2.Catalog.Product
  alias PentoP2.Survey.Rating

  def base, do: Product

  def with_user_rating(user) do
    base()
    |> preload_user_ratings(user)
  end

  def preload_user_ratings(query, user) do
    ratings_query = Rating.Query.preload_user(user)

    query
    |> preload(ratings: ^ratings_query)
  end
end
