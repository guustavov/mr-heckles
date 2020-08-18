defmodule MrHecklesWeb.CompanyController do
  use MrHecklesWeb, :controller

  alias MrHeckles.Companies.{Companies, Company}

  action_fallback MrHecklesWeb.FallbackController

  def index(conn, _params) do
    companies = Companies.list()
    render(conn, "index.json", companies: companies)
  end

  def create(conn, %{"company" => company_params}) do
    with {:ok, %Company{} = company} <- Companies.create(company_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.company_path(conn, :show, company))
      |> render("show.json", company: company)
    end
  end

  def show(conn, %{"id" => id}) do
    company = Companies.get!(id)
    render(conn, "show.json", company: company)
  end

  def update(conn, %{"id" => id, "company" => company_params}) do
    company = Companies.get!(id)

    with {:ok, %Company{} = company} <- Companies.update(company, company_params) do
      render(conn, "show.json", company: company)
    end
  end

  def delete(conn, %{"id" => id}) do
    company = Companies.get!(id)

    with {:ok, %Company{}} <- Companies.delete(company) do
      send_resp(conn, :no_content, "")
    end
  end
end
