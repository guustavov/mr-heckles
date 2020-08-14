defmodule MrHeckles.Companies.Companies do
  @moduledoc """
  Companies operations.
  """

  alias MrHeckles.{Companies.Company, Repo}

  @doc """
  List all existent companies.
  """
  def list, do: Repo.all(Company)

  @doc """
  Get a company with the given id.
  """
  def get!(id), do: Repo.get!(Company, id)

  @doc """
  Create a company.
  """
  def create(params) do
    %Company{}
    |> Company.changeset(params)
    |> Repo.insert()
  end

  @doc """
  Updates a company.
  """
  def update(%Company{} = company, attrs) do
    company
    |> Company.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a company.
  """
  def delete(%Company{} = company), do: Repo.delete(company, [stale_error_field: :id])
end
