defmodule TestsWeb.PassengerLiveTest do
  use TestsWeb.ConnCase

  import Phoenix.LiveViewTest
  import Tests.FleetFixtures

  @create_attrs %{first_name: "some first_name", last_name: "some last_name", document_number: "some document_number", seat_number: "some seat_number"}
  @update_attrs %{first_name: "some updated first_name", last_name: "some updated last_name", document_number: "some updated document_number", seat_number: "some updated seat_number"}
  @invalid_attrs %{first_name: nil, last_name: nil, document_number: nil, seat_number: nil}

  defp create_passenger(_) do
    passenger = passenger_fixture()
    %{passenger: passenger}
  end

  describe "Index" do
    setup [:create_passenger]

    test "lists all passengers", %{conn: conn, passenger: passenger} do
      {:ok, _index_live, html} = live(conn, ~p"/passengers")

      assert html =~ "Listing Passengers"
      assert html =~ passenger.first_name
    end

    test "saves new passenger", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/passengers")

      assert index_live |> element("a", "New Passenger") |> render_click() =~
               "New Passenger"

      assert_patch(index_live, ~p"/passengers/new")

      assert index_live
             |> form("#passenger-form", passenger: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#passenger-form", passenger: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/passengers")

      html = render(index_live)
      assert html =~ "Passenger created successfully"
      assert html =~ "some first_name"
    end

    test "updates passenger in listing", %{conn: conn, passenger: passenger} do
      {:ok, index_live, _html} = live(conn, ~p"/passengers")

      assert index_live |> element("#passengers-#{passenger.id} a", "Edit") |> render_click() =~
               "Edit Passenger"

      assert_patch(index_live, ~p"/passengers/#{passenger}/edit")

      assert index_live
             |> form("#passenger-form", passenger: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#passenger-form", passenger: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/passengers")

      html = render(index_live)
      assert html =~ "Passenger updated successfully"
      assert html =~ "some updated first_name"
    end

    test "deletes passenger in listing", %{conn: conn, passenger: passenger} do
      {:ok, index_live, _html} = live(conn, ~p"/passengers")

      assert index_live |> element("#passengers-#{passenger.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#passengers-#{passenger.id}")
    end
  end

  describe "Show" do
    setup [:create_passenger]

    test "displays passenger", %{conn: conn, passenger: passenger} do
      {:ok, _show_live, html} = live(conn, ~p"/passengers/#{passenger}")

      assert html =~ "Show Passenger"
      assert html =~ passenger.first_name
    end

    test "updates passenger within modal", %{conn: conn, passenger: passenger} do
      {:ok, show_live, _html} = live(conn, ~p"/passengers/#{passenger}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Passenger"

      assert_patch(show_live, ~p"/passengers/#{passenger}/show/edit")

      assert show_live
             |> form("#passenger-form", passenger: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#passenger-form", passenger: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/passengers/#{passenger}")

      html = render(show_live)
      assert html =~ "Passenger updated successfully"
      assert html =~ "some updated first_name"
    end
  end
end
