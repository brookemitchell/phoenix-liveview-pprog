defmodule PentoP2Web.UserAuthLive do
  import Phoenix.LiveView
  alias PentoP2.Accounts

  def on_mount(_, _params, %{"user_token" => user_token}, socket) do
    socket =
      socket
      |> assign(:current_user, Accounts.get_user_by_session_token(user_token))

    if socket.assigns.current_user do
      {:cont, socket}
    else
      {:halt, redirect(socket, to: "/users/log_in")}
    end
  end
end
