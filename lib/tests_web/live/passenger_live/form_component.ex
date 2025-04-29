defmodule TestsWeb.PassengerLive.FormComponent do
  use TestsWeb, :live_component

  alias Tests.Fleet

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage passenger records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="passenger-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:first_name]} type="text" label="First name" />
        <.input field={@form[:last_name]} type="text" label="Last name" />
        <.input field={@form[:document_number]} type="text" label="Document number" />
        <.input field={@form[:seat_number]} type="text" label="Seat number" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Passenger</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{passenger: passenger} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Fleet.change_passenger(passenger))
     end)}
  end

  @impl true
  def handle_event("validate", %{"passenger" => passenger_params}, socket) do
    changeset = Fleet.change_passenger(socket.assigns.passenger, passenger_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"passenger" => passenger_params}, socket) do
    save_passenger(socket, socket.assigns.action, passenger_params)
  end

  defp save_passenger(socket, :edit, passenger_params) do
    case Fleet.update_passenger(socket.assigns.passenger, passenger_params) do
      {:ok, passenger} ->
        notify_parent({:saved, passenger})

        {:noreply,
         socket
         |> put_flash(:info, "Passenger updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_passenger(socket, :new, passenger_params) do
    case Fleet.create_passenger(passenger_params) do
      {:ok, passenger} ->
        notify_parent({:saved, passenger})

        {:noreply,
         socket
         |> put_flash(:info, "Passenger created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
