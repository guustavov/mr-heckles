defmodule MrHeckles.Company do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  schema "companies" do
    field :description, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(company, attrs) do
    company
    |> cast(attrs, [:name, :description])
    |> validate_required([:name])
  end
end
