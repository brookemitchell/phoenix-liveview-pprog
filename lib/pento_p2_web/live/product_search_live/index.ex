defmodule PentoP2Web.ProductSearchLive.Index do
  alias PentoP2.Catalog
  alias PentoP2.Search
  use PentoP2Web, :live_view

  def assign_changeset(%{assigns: %{search: search}} = socket) do
    socket
    |> assign(:changeset, Search.changeset(search))
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:search, %Search{})
     |> assign(:trigger_submit, false)
     |> assign_changeset()}
  end

  def update(%{search: search} = assigns, socket) do
    {
      :ok,
      socket
      |> assign(assigns)
      |> assign(
        :changeset,
        Search.change_search(search)
      )
    }
  end

  @impl true
  def handle_event("validate", %{"search" => search_params}, socket) do
    changeset =
      socket.assigns.search
      |> Search.change_search(search_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  # save_product(socket, socket.assigns.action, product_params)
  @impl true
  def handle_event(
        "save",
        %{"search" => search_params = %{"sku" => search_sku_param}},
        socket
      ) do
    changeset = Search.change_search(socket.assigns.search, search_params)

    with {search_sku_number, _} <- Integer.parse(search_sku_param),
         %{id: id} <- Catalog.get_product_by_attr(sku: search_sku_number) do
      {:noreply,
       socket
       |> put_flash(:info, "Product found")
       |> push_redirect(to: "/products/#{id}")}
    else
      error ->
        IO.inspect(error)

        {:noreply,
         socket
         |> assign(:changeset, changeset)
         |> put_flash(:error, "Product not found")}
    end
  end
end
