defmodule PentoP2Web.SurveyLive do
  use PentoP2Web, :live_view
  alias PentoP2Web.DemographicLive
  alias PentoP2.Survey

  def mount(_params, _session, socket) do
    {
      :ok,
      socket
      |> assign_demographic
    }
  end

  def handle_info({:created_demographic, demographic}, socket) do
    {:noreply, handle_demographic_created(socket, demographic)}
  end

  def handle_demographic_created(socket, demographic) do
    socket
    |> put_flash(:info, "Demographic successfully created")
    |> assign(:demographic, demographic)
  end

  defp assign_demographic(%{assigns: %{current_user: current_user}} = socket) do
    assign(socket, :demographic, Survey.get_demographic_by_user(current_user))
  end
end
