defmodule PentoP2Web.DemographicLive.Form do
  use PentoP2Web, :live_component
  alias PentoP2.Survey
  alias PentoP2.Survey.Demographic

  def update(assigns, socket) do
    {
      :ok,
      socket
      |> assign(assigns)
      |> assign_demographic()
      |> assign_changeset()
    }
  end

  def handle_event("save", %{"demographic" => demographic_params}, socket) do
    {:noreply, save_demographic(socket, demographic_params)}
  end

  defp assign_demographic(%{assigns: %{current_user: current_user}} = socket) do
    assign(socket, :demographic, %Demographic{user_id: current_user.id})
  end

  defp assign_changeset(%{assigns: %{demographic: demographic}} = socket) do
    assign(socket, :changeset, Survey.change_demographic(demographic))
  end

  defp save_demographic(socket, demographic_params) do
    case Survey.create_demographic(demographic_params) do
      {:ok, demographic} ->
        send(self(), {:created_demographic, demographic})
        socket

      {:error, %Ecto.Changeset{} = changeset} ->
        assign(socket, :changeset, changeset)
    end
  end
end
