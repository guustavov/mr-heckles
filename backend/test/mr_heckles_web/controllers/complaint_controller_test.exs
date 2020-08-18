defmodule MrHecklesWeb.ComplaintControllerTest do
  use MrHecklesWeb.ConnCase

  import MrHeckles.Factory

  alias MrHeckles.{Companies.Company, Complaints.Complaint}

  @create_attrs %{
    city: "some city",
    country: "some country",
    description: "some description",
    latitude: "some latitude",
    longitude: "some longitude",
    state: "some state",
    title: "some title"
  }
  @update_attrs %{
    city: "some updated city",
    country: "some updated country",
    description: "some updated description",
    latitude: "some updated latitude",
    longitude: "some updated longitude",
    state: "some updated state",
    title: "some updated title"
  }
  @invalid_attrs %{
    city: nil,
    country: nil,
    description: nil,
    latitude: nil,
    longitude: nil,
    state: nil,
    title: nil
  }

  def fixture(:complaint) do
    insert(:complaint)
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all complaints", %{conn: conn} do
      conn = get(conn, Routes.complaint_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create complaint" do
    test "renders complaint when data is valid", %{conn: conn} do
      %Company{id: company_id} = insert(:company)

      conn =
        post(conn, Routes.complaint_path(conn, :create),
          complaint: Map.merge(@create_attrs, %{company_id: company_id})
        )

      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.complaint_path(conn, :show, id))

      assert %{
               "id" => id,
               "city" => "some city",
               "country" => "some country",
               "description" => "some description",
               "state" => "some state",
               "title" => "some title"
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
      conn = put(conn, Routes.complaint_path(conn, :update, complaint), complaint: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.complaint_path(conn, :show, id))

      assert %{
               "id" => id,
               "city" => "some updated city",
               "country" => "some updated country",
               "description" => "some updated description",
               "state" => "some updated state",
               "title" => "some updated title"
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
    complaint = fixture(:complaint)
    %{complaint: complaint}
  end
end
