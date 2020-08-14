defmodule MrHeckles.CompaniesTest do
  use MrHeckles.DataCase, async: true

  import MrHeckles.Factory

  alias MrHeckles.Companies.{Companies, Company}

  describe "list/0" do
    test "returns all existent companies" do
      company = insert(:company)

      assert companies = Companies.list()
      assert companies == [company]
      assert length(companies) == 1
    end
  end

  describe "get/1" do
    test "returns company corresponding to given id" do
      company = insert(:company)

      assert company == Companies.get!(company.id)
    end
  end

  describe "create/1" do
    test "sucessfully creates a company and returns a struct when params are valid" do
      params = %{name: "Valid name", description: "Valid description"}

      assert {:ok, %Company{} = company} = Companies.create(params)
      assert company.name == "Valid name"
      assert company.description == "Valid description"
    end

    test "returns error when name is missing" do
      params = %{name: "", description: "Valid description"}

      assert {:error, %Ecto.Changeset{} = changeset} = Companies.create(params)
      %{name: ["can't be blank"]} = errors_on(changeset)
    end
  end

  describe "update/2" do
    test "sucessfully updates company and return updated struct with updated data" do
      company = insert(:company)

      assert {:ok, %Company{} = company} =
               Companies.update(company, %{description: "New description value"})

      assert company.description == "New description value"
    end

    test "returns error changeset when data is invalid" do
      company = insert(:company)

      assert {:error, %Ecto.Changeset{}} = Companies.update(company, %{name: ""})

      assert company == Companies.get!(company.id)
    end
  end

  describe "delete/1" do
    test "deletes the given company" do
      company = insert(:company)

      assert {:ok, _} = Companies.delete(company)
    end

    test "fails to delete unexistent company" do
      company = insert(:company)

      assert {:error, _} = Companies.delete(%{company | id: -1})
    end
  end
end
