defmodule MrHeckles.Complaints do
  @moduledoc """
  The Complaints context.
  """

  import Ecto.Query, warn: false
  alias MrHeckles.Repo

  alias MrHeckles.Complaints.Complaint

  @doc """
  Build a query with given filters (if there is any) and returns the list of complaints.

  ## Examples

      iex> list_complaints()
      [%Complaint{}, ...]

  """
  def list_complaints(filters \\ %{}) do
    build_query(filters)
    |> Repo.all()
  end

  defp base_query do
    from(complaints in Complaint)
  end

  defp build_query(filters) do
    query = base_query()

    query
    |> maybe_filter_by_city(filters["city"])
    |> maybe_filter_by_company_id(filters["company_id"])
    |> maybe_filter_by_country(filters["country"])
    |> maybe_filter_by_state(filters["state"])
  end

  defp maybe_filter_by_city(query, nil), do: query

  defp maybe_filter_by_city(query, city) do
    from(complaints in query, where: complaints.city == ^city)
  end

  defp maybe_filter_by_company_id(query, nil), do: query

  defp maybe_filter_by_company_id(query, company_id) do
    from(complaints in query, where: complaints.company_id == ^company_id)
  end

  defp maybe_filter_by_country(query, nil), do: query

  defp maybe_filter_by_country(query, country) do
    from(complaints in query, where: complaints.country == ^country)
  end

  defp maybe_filter_by_state(query, nil), do: query

  defp maybe_filter_by_state(query, state) do
    from(complaints in query, where: complaints.state == ^state)
  end

  @doc """
  Gets a single complaint.

  Raises `Ecto.NoResultsError` if the Complaint does not exist.

  ## Examples

      iex> get_complaint!(123)
      %Complaint{}

      iex> get_complaint!(456)
      ** (Ecto.NoResultsError)

  """
  def get_complaint!(id), do: Repo.get!(Complaint, id)

  @doc """
  Creates a complaint.

  ## Examples

      iex> create_complaint(%{field: value})
      {:ok, %Complaint{}}

      iex> create_complaint(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_complaint(attrs \\ %{}) do
    %Complaint{}
    |> Complaint.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a complaint.

  ## Examples

      iex> update_complaint(complaint, %{field: new_value})
      {:ok, %Complaint{}}

      iex> update_complaint(complaint, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_complaint(%Complaint{} = complaint, attrs) do
    complaint
    |> Complaint.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a complaint.

  ## Examples

      iex> delete_complaint(complaint)
      {:ok, %Complaint{}}

      iex> delete_complaint(complaint)
      {:error, %Ecto.Changeset{}}

  """
  def delete_complaint(%Complaint{} = complaint) do
    Repo.delete(complaint)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking complaint changes.

  ## Examples

      iex> change_complaint(complaint)
      %Ecto.Changeset{data: %Complaint{}}

  """
  def change_complaint(%Complaint{} = complaint, attrs \\ %{}) do
    Complaint.changeset(complaint, attrs)
  end
end
