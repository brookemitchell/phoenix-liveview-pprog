defmodule PentoP2Web.SurveyActivityLive do
  alias PentoP2Web.Presence
  use PentoP2Web, :live_component

  def update(_assigns, socket) do
    {:ok, socket |> assign_user_activity()}
  end

  def assign_user_activity(socket) do
    assign(socket, :user_activity, Presence.list_survey_users())
  end
end
