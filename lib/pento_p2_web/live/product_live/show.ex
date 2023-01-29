defmodule PentoP2Web.ProductLive.Show do
  use PentoP2Web, :live_view

  alias PentoP2Web.Presence
  alias PentoP2.Catalog

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    product = Catalog.get_product!(id)
    maybe_track_user(product, socket)

    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:product, product)}
  end

  defp page_title(:show), do: "Show Product"
  defp page_title(:edit), do: "Edit Product"

  def maybe_track_user(
        product,
        %{
          assigns: %{
            current_user: current_user,
            live_action: :show
          }
        } = socket
      ) do
    if connected?(socket) do
      Presence.track_user(self(), product, current_user.email)
    end
  end

  def maybe_track_user(_product, _socket), do: nil
end
