defmodule PentoP2Web.Presence do
  use Phoenix.Presence,
    otp_app: :pento_p2,
    pubsub_server: PentoP2.PubSub

  alias PentoP2Web.Presence
  # alias Pento.Accounts

  @user_activity_topic "user_activity"

  def track_user(pid, product, email) do
    Presence.track(
      pid,
      @user_activity_topic,
      product.name,
      %{users: [%{email: email}]}
    )
  end

  def list_users_and_products do
    Presence.list(@user_activity_topic)
    |> Enum.map(&extract_product_with_users/1)
  end

  defp extract_product_with_users({product_name, %{metas: metas}}) do
    {product_name, users_from_metas(metas)}
  end

  defp users_from_metas(metas_list) do
    Enum.map(metas_list, &users_from_meta_map/1)
    |> List.flatten()
    |> Enum.uniq()
  end

  defp users_from_meta_map(meta_map) do
    get_in(meta_map, [:users])
  end
end
