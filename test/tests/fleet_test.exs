defmodule Tests.FleetTest do
  use Tests.DataCase

  alias Tests.Fleet

  describe "airplanes" do
    alias Tests.Fleet.Airplane

    import Tests.FleetFixtures

    @invalid_attrs %{status: nil, model: nil, capacity: nil}

    test "list_airplanes/0 returns all airplanes" do
      airplane = airplane_fixture()
      assert Fleet.list_airplanes() == [airplane]
    end

    test "get_airplane!/1 returns the airplane with given id" do
      airplane = airplane_fixture()
      assert Fleet.get_airplane!(airplane.id) == airplane
    end

    test "create_airplane/1 with valid data creates a airplane" do
      valid_attrs = %{status: "some status", model: "some model", capacity: 42}

      assert {:ok, %Airplane{} = airplane} = Fleet.create_airplane(valid_attrs)
      assert airplane.status == "some status"
      assert airplane.model == "some model"
      assert airplane.capacity == 42
    end

    test "create_airplane/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Fleet.create_airplane(@invalid_attrs)
    end

    test "update_airplane/2 with valid data updates the airplane" do
      airplane = airplane_fixture()
      update_attrs = %{status: "some updated status", model: "some updated model", capacity: 43}

      assert {:ok, %Airplane{} = airplane} = Fleet.update_airplane(airplane, update_attrs)
      assert airplane.status == "some updated status"
      assert airplane.model == "some updated model"
      assert airplane.capacity == 43
    end

    test "update_airplane/2 with invalid data returns error changeset" do
      airplane = airplane_fixture()
      assert {:error, %Ecto.Changeset{}} = Fleet.update_airplane(airplane, @invalid_attrs)
      assert airplane == Fleet.get_airplane!(airplane.id)
    end

    test "delete_airplane/1 deletes the airplane" do
      airplane = airplane_fixture()
      assert {:ok, %Airplane{}} = Fleet.delete_airplane(airplane)
      assert_raise Ecto.NoResultsError, fn -> Fleet.get_airplane!(airplane.id) end
    end

    test "change_airplane/1 returns a airplane changeset" do
      airplane = airplane_fixture()
      assert %Ecto.Changeset{} = Fleet.change_airplane(airplane)
    end
  end

  describe "passengers" do
    alias Tests.Fleet.Passenger

    import Tests.FleetFixtures

    @invalid_attrs %{first_name: nil, last_name: nil, document_number: nil, seat_number: nil}

    test "list_passengers/0 returns all passengers" do
      passenger = passenger_fixture()
      assert Fleet.list_passengers() == [passenger]
    end

    test "get_passenger!/1 returns the passenger with given id" do
      passenger = passenger_fixture()
      assert Fleet.get_passenger!(passenger.id) == passenger
    end

    test "create_passenger/1 with valid data creates a passenger" do
      valid_attrs = %{first_name: "some first_name", last_name: "some last_name", document_number: "some document_number", seat_number: "some seat_number"}

      assert {:ok, %Passenger{} = passenger} = Fleet.create_passenger(valid_attrs)
      assert passenger.first_name == "some first_name"
      assert passenger.last_name == "some last_name"
      assert passenger.document_number == "some document_number"
      assert passenger.seat_number == "some seat_number"
    end

    test "create_passenger/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Fleet.create_passenger(@invalid_attrs)
    end

    test "update_passenger/2 with valid data updates the passenger" do
      passenger = passenger_fixture()
      update_attrs = %{first_name: "some updated first_name", last_name: "some updated last_name", document_number: "some updated document_number", seat_number: "some updated seat_number"}

      assert {:ok, %Passenger{} = passenger} = Fleet.update_passenger(passenger, update_attrs)
      assert passenger.first_name == "some updated first_name"
      assert passenger.last_name == "some updated last_name"
      assert passenger.document_number == "some updated document_number"
      assert passenger.seat_number == "some updated seat_number"
    end

    test "update_passenger/2 with invalid data returns error changeset" do
      passenger = passenger_fixture()
      assert {:error, %Ecto.Changeset{}} = Fleet.update_passenger(passenger, @invalid_attrs)
      assert passenger == Fleet.get_passenger!(passenger.id)
    end

    test "delete_passenger/1 deletes the passenger" do
      passenger = passenger_fixture()
      assert {:ok, %Passenger{}} = Fleet.delete_passenger(passenger)
      assert_raise Ecto.NoResultsError, fn -> Fleet.get_passenger!(passenger.id) end
    end

    test "change_passenger/1 returns a passenger changeset" do
      passenger = passenger_fixture()
      assert %Ecto.Changeset{} = Fleet.change_passenger(passenger)
    end
  end
end
