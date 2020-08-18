defmodule MrHeckles.Complaints.Complaint do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  alias MrHeckles.Companies.Company

  schema "complaints" do
    field :city, :string
    field :country, :string
    field :description, :string
    field :latitude, :string, virtual: true
    field :longitude, :string, virtual: true
    field :state, :string
    field :title, :string

    belongs_to :company, Company

    timestamps()
  end

  @doc false
  def changeset(complaint, attrs) do
    complaint
    |> cast(attrs, [
      :title,
      :description,
      :city,
      :state,
      :country,
      :company_id
    ])
    |> validate_required([:title, :city, :state, :country, :company_id])
  end
end
