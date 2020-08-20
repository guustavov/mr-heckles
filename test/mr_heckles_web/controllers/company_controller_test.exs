defmodule MrHecklesWeb.CompanyControllerTest do
  use MrHecklesWeb.ConnCase

  import MrHeckles.Factory

  alias MrHeckles.Companies.Company

  @invalid_attrs %{name: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all companies", %{conn: conn} do
      conn = get(conn, Routes.company_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create company" do
    test "renders company when data is valid", %{conn: conn} do
      conn = post(conn, Routes.company_path(conn, :create), company: params_for(:company))
      assert %{"id" => id, "description" => description} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.company_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "description" => ^description
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.company_path(conn, :create), company: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update company" do
    setup [:create_company]

    test "renders company when data is valid", %{conn: conn, company: %Company{id: id} = company} do
      updated_fields = %{name: "updated name", description: "updated description"}

      conn =
        put(conn, Routes.company_path(conn, :update, company),
          company: Map.merge(params_for(:company), updated_fields)
        )

      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.company_path(conn, :show, id))

      %{name: updated_name, description: updated_description} = updated_fields

      assert %{
               "id" => ^id,
               "description" => ^updated_description,
               "name" => ^updated_name
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, company: company} do
      conn = put(conn, Routes.company_path(conn, :update, company), company: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete company" do
    setup [:create_company]

    test "deletes chosen company", %{conn: conn, company: company} do
      conn = delete(conn, Routes.company_path(conn, :delete, company))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.company_path(conn, :show, company))
      end
    end
  end

  defp create_company(_) do
    %{company: insert(:company)}
  end
end
