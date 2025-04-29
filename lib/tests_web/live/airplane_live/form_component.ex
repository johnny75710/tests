defmodule TestsWeb.AirplaneLive.FormComponent do
  use TestsWeb, :live_component

  alias Tests.Fleet

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage airplane records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="airplane-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:model]} type="text" label="Model" />
        <.input field={@form[:capacity]} type="number" label="Capacity" />
        <.input field={@form[:status]} type="text" label="Status" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Airplane</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{airplane: airplane} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Fleet.change_airplane(airplane))
     end)}
  end

  @impl true
  def handle_event("validate", %{"airplane" => airplane_params}, socket) do
    changeset = Fleet.change_airplane(socket.assigns.airplane, airplane_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"airplane" => airplane_params}, socket) do
    save_airplane(socket, socket.assigns.action, airplane_params)
  end

  defp save_airplane(socket, :edit, airplane_params) do
    case Fleet.update_airplane(socket.assigns.airplane, airplane_params) do
      {:ok, airplane} ->
        notify_parent({:saved, airplane})

        {:noreply,
         socket
         |> put_flash(:info, "Airplane updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_airplane(socket, :new, airplane_params) do
    case Fleet.create_airplane(airplane_params) do
      {:ok, airplane} ->
        notify_parent({:saved, airplane})

        {:noreply,
         socket
         |> put_flash(:info, "Airplane created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
