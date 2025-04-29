defmodule Tests.Repo.Migrations.CreatePassengers do
  use Ecto.Migration

  def change do
    create table(:passengers) do
      add :first_name, :string
      add :last_name, :string
      add :document_number, :string
      add :seat_number, :string

      timestamps(type: :utc_datetime)
    end
  end
end
