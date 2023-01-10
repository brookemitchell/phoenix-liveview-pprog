defmodule PentoP2Web.SurveyLive do
  use PentoP2Web, :live_view
  alias PentoP2Web.DemographicLive
  alias PentoP2.Survey

  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign_demographic()}
  end

  defp assign_demographic(%{assigns: %{current_user: current_user}} = socket) do
    assign(socket, :demographic, Survey.get_demographic_by_user(current_user))
  end

  def list_item(assigns) do
    ~H"""
      <li><%= @item %></li>
    """
  end

  def list(assigns) do
    ~H"""
      <ul>
      <%= for item <- @li do %>
        <.list_item item={render_slot(item)} />
      <% end %>
      </ul>
    """
  end
end
