defmodule PentoP2Web.Admin.SurveyResultsLive do
  use PentoP2Web, :live_component

  alias PentoP2.Catalog

  def update(assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_products_with_average_ratings()}
  end

  defp assign_products_with_average_ratings(socket) do
    socket
    |> assign(
      :products_with_average_ratings,
      Catalog.products_with_average_ratings()
    )
  end

  def render(assigns) do
    ~H"""
      <div>
        <ul>
        <%= for  {name, rating} <- @products_with_average_ratings do %>
          <li><%= name %> - <%= rating %></li>
        <% end %>
        </ul>
      </div>
    """
  end
end
