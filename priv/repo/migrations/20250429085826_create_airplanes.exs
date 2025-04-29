defmodule Tests.Repo.Migrations.CreateAirplanes do
  use Ecto.Migration

  def change do
    create table(:airplanes) do
      add :model, :string
      add :capacity, :integer
      add :status, :string

      timestamps(type: :utc_datetime)
    end
  end
end
