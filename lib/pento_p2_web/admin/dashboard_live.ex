defmodule PentoP2Web.Admin.DashboardLive do
  use PentoP2Web, :live_view
  alias PentoP2Web.Admin.SurveyResultsLive
  alias PentoP2Web.Endpoint

  @survey_results_topic "survey_results"

  def mount(_params, _session, socket) do
    if connected?(socket) do
      Endpoint.subscribe(@survey_results_topic)
    end

    {:ok,
     socket
     |> assign(:survey_results_component_id, "survey-results")}
  end

  def handle_info(%{event: "rating_created"}, socket) do
    send_update(
      SurveyResultsLive,
      id: socket.assigns.survey_results_component_id
    )

    {:noreply, socket}
  end
end
