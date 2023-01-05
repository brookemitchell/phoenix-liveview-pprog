defmodule PentoP2Web.ProductLive.FormComponent do
  use PentoP2Web, :live_component

  alias PentoP2.Catalog

  @impl true
  def update(%{product: product} = assigns, socket) do
    changeset = Catalog.change_product(product)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)
     |> allow_upload(:image,
       accept: ~w(.jpg .jpeg .png),
       max_entries: 1,
       max_file_size: 9_000_000,
       auto_upload: true,
       progress: &handle_progress/3
     )}
  end

  defp handle_progress(:image, entry, socket) do
    if entry.done? do
      path = consume_uploaded_entry(socket, entry, &upload_static_file(&1, socket))

      {:noreply,
       socket
       |> put_flash(:info, "file #{entry.client_name} uploaded")
       |> assign(:image_upload, path)}
    else
      {:noreply, socket}
    end
  end

  defp upload_static_file(%{path: path}, socket) do
    # add s3 image file persist here
    dest = Path.join("priv/static/images", Path.basename(path))
    File.cp!(path, dest)
    {:ok, Routes.static_path(socket, "/images/#{Path.basename(dest)}")}
  end

  @impl true
  def handle_event("validate", %{"product" => product_params}, socket) do
    changeset =
      socket.assigns.product
      |> Catalog.change_product(product_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"product" => product_params}, socket) do
    save_product(socket, socket.assigns.action, product_params)
  end

  defp product_params(%{assigns: %{image_upload: socket_image_upload}} = _socket, params) do
    Map.put(params, "image_upload", socket_image_upload)
  end

  defp product_params(_socket, params), do: params

  defp save_product(socket, :edit, params) do
    result = Catalog.update_product(socket.assigns.product, product_params(socket, params))

    case result do
      {:ok, _product} ->
        {:noreply,
         socket
         |> put_flash(:info, "Product updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_product(socket, :new, params) do
    case Catalog.create_product(product_params(socket, params)) do
      {:ok, _product} ->
        {:noreply,
         socket
         |> put_flash(:info, "Product created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  def upload_image_error(%{image: %{errors: errors}}, entry)
      when length(errors) > 0 do
    {_, msg} =
      Enum.find(
        errors,
        fn {ref, _} -> ref == entry.ref || ref == entry.upload.ref end
      )

    Atom.to_string(msg)
  end

  def upload_image_error(_, _), do: ""
end
