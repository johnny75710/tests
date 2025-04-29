defmodule MyApp.Repo.Migrations.CreateAirplanesPassengers do
  use Ecto.Migration

  def change do
    create table(:airplanes_passengers) do
      add :airplane_id, references(:airplanes, on_delete: :delete_all)
      add :passenger_id, references(:passengers, on_delete: :delete_all)

      timestamps()
    end

    create index(:airplanes_passengers, [:airplane_id])
    create index(:airplanes_passengers, [:passenger_id])
    create unique_index(:airplanes_passengers, [:airplane_id, :passenger_id])
  end
end
