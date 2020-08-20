defmodule MrHecklesWeb.ComplaintControllerTest do
  use MrHecklesWeb.ConnCase

  import MrHeckles.Factory

  alias MrHeckles.{Companies.Company, Complaints.Complaint}

  @invalid_attrs %{
    city: nil,
    country: nil,
    description: nil,
    latitude: nil,
    longitude: nil,
    state: nil,
    title: nil
  }

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all complaints", %{conn: conn} do
      conn = get(conn, Routes.complaint_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end

    test "lists complaints of a specific company", %{conn: conn} do
      conn = get(conn, Routes.complaint_path(conn, :index, %{"company_id" => 1}))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create complaint" do
    test "renders complaint when data is valid", %{conn: conn} do
      %Company{id: company_id} = insert(:company)

      %{city: city, country: country, description: description, state: state, title: title} =
        params = params_for(:complaint)

      conn =
        post(conn, Routes.complaint_path(conn, :create),
          complaint: Map.merge(params, %{company_id: company_id})
        )

      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.complaint_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "city" => ^city,
               "country" => ^country,
               "description" => ^description,
               "state" => ^state,
               "title" => ^title
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.complaint_path(conn, :create), complaint: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update complaint" do
    setup [:create_complaint]

    test "renders complaint when data is valid", %{
      conn: conn,
      complaint: %Complaint{id: id} = complaint
    } do
      updated_fields = %{
        city: "updated city",
        country: "updated country",
        description: "updated description",
        latitude: "updated latitude",
        longitude: "updated longitude",
        state: "updated state",
        title: "updated title"
      }

      conn = put(conn, Routes.complaint_path(conn, :update, complaint), complaint: updated_fields)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.complaint_path(conn, :show, id))

      %{
        city: updated_city,
        country: updated_country,
        description: updated_description,
        state: updated_state,
        title: updated_title
      } = updated_fields

      assert %{
               "id" => ^id,
               "city" => ^updated_city,
               "country" => ^updated_country,
               "description" => ^updated_description,
               "state" => ^updated_state,
               "title" => ^updated_title
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, complaint: complaint} do
      conn = put(conn, Routes.complaint_path(conn, :update, complaint), complaint: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete complaint" do
    setup [:create_complaint]

    test "deletes chosen complaint", %{conn: conn, complaint: complaint} do
      conn = delete(conn, Routes.complaint_path(conn, :delete, complaint))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.complaint_path(conn, :show, complaint))
      end
    end
  end

  defp create_complaint(_) do
    %{complaint: insert(:complaint)}
  end
end
