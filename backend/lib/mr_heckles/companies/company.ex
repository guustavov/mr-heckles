defmodule MrHeckles.Companies.Company do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  alias MrHeckles.Complaints.Complaint

  schema "companies" do
    field :description, :string
    field :name, :string

    has_many :complaints, Complaint

    timestamps()
  end

  @doc false
  def changeset(company, attrs) do
    company
    |> cast(attrs, [:name, :description])
    |> validate_required([:name])
  end
end
