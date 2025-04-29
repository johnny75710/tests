defmodule Tests.Fleet do
  @moduledoc """
  The Fleet context.
  """

  import Ecto.Query, warn: false
  alias Tests.Repo

  alias Tests.Fleet.Airplane

  @doc """
  Returns the list of airplanes.

  ## Examples

      iex> list_airplanes()
      [%Airplane{}, ...]

  """
  def list_airplanes do
    Repo.all(Airplane)
  end

  @doc """
  Gets a single airplane.

  Raises `Ecto.NoResultsError` if the Airplane does not exist.

  ## Examples

      iex> get_airplane!(123)
      %Airplane{}

      iex> get_airplane!(456)
      ** (Ecto.NoResultsError)

  """
  def get_airplane!(id), do: Repo.get!(Airplane, id)

  @doc """
  Creates a airplane.

  ## Examples

      iex> create_airplane(%{field: value})
      {:ok, %Airplane{}}

      iex> create_airplane(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_airplane(attrs \\ %{}) do
    %Airplane{}
    |> Airplane.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a airplane.

  ## Examples

      iex> update_airplane(airplane, %{field: new_value})
      {:ok, %Airplane{}}

      iex> update_airplane(airplane, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_airplane(%Airplane{} = airplane, attrs) do
    airplane
    |> Airplane.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a airplane.

  ## Examples

      iex> delete_airplane(airplane)
      {:ok, %Airplane{}}

      iex> delete_airplane(airplane)
      {:error, %Ecto.Changeset{}}

  """
  def delete_airplane(%Airplane{} = airplane) do
    Repo.delete(airplane)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking airplane changes.

  ## Examples

      iex> change_airplane(airplane)
      %Ecto.Changeset{data: %Airplane{}}

  """
  def change_airplane(%Airplane{} = airplane, attrs \\ %{}) do
    Airplane.changeset(airplane, attrs)
  end

  alias Tests.Fleet.Passenger

  @doc """
  Returns the list of passengers.

  ## Examples

      iex> list_passengers()
      [%Passenger{}, ...]

  """
  def list_passengers do
    Repo.all(Passenger)
  end

  @doc """
  Gets a single passenger.

  Raises `Ecto.NoResultsError` if the Passenger does not exist.

  ## Examples

      iex> get_passenger!(123)
      %Passenger{}

      iex> get_passenger!(456)
      ** (Ecto.NoResultsError)

  """
  def get_passenger!(id), do: Repo.get!(Passenger, id)

  @doc """
  Creates a passenger.

  ## Examples

      iex> create_passenger(%{field: value})
      {:ok, %Passenger{}}

      iex> create_passenger(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_passenger(attrs \\ %{}) do
    %Passenger{}
    |> Passenger.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a passenger.

  ## Examples

      iex> update_passenger(passenger, %{field: new_value})
      {:ok, %Passenger{}}

      iex> update_passenger(passenger, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_passenger(%Passenger{} = passenger, attrs) do
    passenger
    |> Passenger.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a passenger.

  ## Examples

      iex> delete_passenger(passenger)
      {:ok, %Passenger{}}

      iex> delete_passenger(passenger)
      {:error, %Ecto.Changeset{}}

  """
  def delete_passenger(%Passenger{} = passenger) do
    Repo.delete(passenger)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking passenger changes.

  ## Examples

      iex> change_passenger(passenger)
      %Ecto.Changeset{data: %Passenger{}}

  """
  def change_passenger(%Passenger{} = passenger, attrs \\ %{}) do
    Passenger.changeset(passenger, attrs)
  end
end
