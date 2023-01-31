defmodule PentoP2Web.Admin.DashboardLive do
  use PentoP2Web, :live_view
  alias PentoP2Web.SurveyActivityLive
  alias PentoP2Web.UserActivityLive
  alias PentoP2Web.Admin.SurveyResultsLive
  alias PentoP2Web.Endpoint

  @survey_results_topic "survey_results"
  @user_activity_topic "user_activity"
  @survey_activity_topic "survey_activity"

  def mount(_params, _session, socket) do
    if connected?(socket) do
      Endpoint.subscribe(@survey_results_topic)
      Endpoint.subscribe(@user_activity_topic)
      Endpoint.subscribe(@survey_activity_topic)
    end

    {:ok,
     socket
     |> assign(:survey_results_component_id, "survey-results")
     |> assign(:survey_activity_component_id, "survey-activity")
     |> assign(:user_activity_component_id, "user-activity")}
  end

  def handle_info(
        %{
          event: "presence_diff",
          topic: "user_activity"
        } = event,
        socket
      ) do
    send_update(
      UserActivityLive,
      id: socket.assigns.user_activity_component_id
    )

    {:noreply, socket}
  end

  def handle_info(
        %{
          event: "presence_diff",
          topic: "survey_activity"
        } = event,
        socket
      ) do
    send_update(
      SurveyActivityLive,
      id: socket.assigns.survey_activity_component_id
    )

    {:noreply, socket}
  end

  def handle_info(%{event: "rating_created"}, socket) do
    send_update(
      SurveyResultsLive,
      id: socket.assigns.survey_results_component_id
    )

    {:noreply, socket}
  end
end
