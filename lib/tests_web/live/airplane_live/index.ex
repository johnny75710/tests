defmodule TestsWeb.AirplaneLive.Index do
  use TestsWeb, :live_view

  alias Tests.Fleet
  alias Tests.Fleet.Airplane

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :airplanes, Fleet.list_airplanes())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Airplane")
    |> assign(:airplane, Fleet.get_airplane!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Airplane")
    |> assign(:airplane, %Airplane{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Airplanes")
    |> assign(:airplane, nil)
  end

  @impl true
  def handle_info({TestsWeb.AirplaneLive.FormComponent, {:saved, airplane}}, socket) do
    {:noreply, stream_insert(socket, :airplanes, airplane)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    airplane = Fleet.get_airplane!(id)
    {:ok, _} = Fleet.delete_airplane(airplane)

    {:noreply, stream_delete(socket, :airplanes, airplane)}
  end
end
