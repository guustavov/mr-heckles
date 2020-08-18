defmodule MrHeckles.Repo.Migrations.CreateComplaints do
  use Ecto.Migration

  def change do
    create table(:complaints) do
      add :title, :string, null: false
      add :description, :text
      add :city, :string, null: false
      add :state, :string, null: false
      add :country, :string, null: false
      add :company_id, references(:companies, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:complaints, [:company_id])
  end
end
