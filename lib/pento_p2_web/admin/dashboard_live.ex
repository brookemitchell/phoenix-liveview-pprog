defmodule PentoP2Web.Admin.DashboardLive do
  use PentoP2Web, :live_view

  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:survey_results_component_id, "survey-results")}
  end
end
