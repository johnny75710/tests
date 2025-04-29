defmodule Tests.Fleet.Passenger do
  use Ecto.Schema
  import Ecto.Changeset

  schema "passengers" do
    field :first_name, :string
    field :last_name, :string
    field :document_number, :string
    field :seat_number, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(passenger, attrs) do
    passenger
    |> cast(attrs, [:first_name, :last_name, :document_number, :seat_number])
    |> validate_required([:first_name, :last_name, :document_number, :seat_number])
  end
end
