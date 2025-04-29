defmodule Tests.Fleet.Airplane do
  use Ecto.Schema
  import Ecto.Changeset

  schema "airplanes" do
    field :status, :string
    field :model, :string
    field :capacity, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(airplane, attrs) do
    airplane
    |> cast(attrs, [:model, :capacity, :status])
    |> validate_required([:model, :capacity, :status])
  end
end
