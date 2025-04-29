defmodule TestsWeb.PassengerLive.Index do
  use TestsWeb, :live_view

  alias Tests.Fleet
  alias Tests.Fleet.Passenger

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :passengers, Fleet.list_passengers())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Passenger")
    |> assign(:passenger, Fleet.get_passenger!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Passenger")
    |> assign(:passenger, %Passenger{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Passengers")
    |> assign(:passenger, nil)
  end

  @impl true
  def handle_info({TestsWeb.PassengerLive.FormComponent, {:saved, passenger}}, socket) do
    {:noreply, stream_insert(socket, :passengers, passenger)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    passenger = Fleet.get_passenger!(id)
    {:ok, _} = Fleet.delete_passenger(passenger)

    {:noreply, stream_delete(socket, :passengers, passenger)}
  end
end
