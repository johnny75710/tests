defmodule Tests.FleetFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Tests.Fleet` context.
  """

  @doc """
  Generate a airplane.
  """
  def airplane_fixture(attrs \\ %{}) do
    {:ok, airplane} =
      attrs
      |> Enum.into(%{
        capacity: 42,
        model: "some model",
        status: "some status"
      })
      |> Tests.Fleet.create_airplane()

    airplane
  end

  @doc """
  Generate a passenger.
  """
  def passenger_fixture(attrs \\ %{}) do
    {:ok, passenger} =
      attrs
      |> Enum.into(%{
        document_number: "some document_number",
        first_name: "some first_name",
        last_name: "some last_name",
        seat_number: "some seat_number"
      })
      |> Tests.Fleet.create_passenger()

    passenger
  end
end
