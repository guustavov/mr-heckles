defmodule MrHeckles.Companies do
  @moduledoc """
  Companies operations.
  """

  alias MrHeckles.{Company, Repo}

  @doc """
  List all existent companies.
  """
  def list, do: Repo.all(Company)

  @doc """
  Find a company with the given id.
  """
  def find(id), do: Repo.get(Company, id)

  @doc """
  Create a company.
  """
  def create(params) do
    %Company{}
    |> Company.changeset(params)
    |> Repo.insert()
  end

  @doc """
  Deletes a company.
  """
  def delete(%Company{} = company), do: Repo.delete(company, [stale_error_field: :id])
end
