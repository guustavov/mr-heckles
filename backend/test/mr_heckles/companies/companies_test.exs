defmodule MrHeckles.CompaniesTest do
  use MrHeckles.DataCase, async: true

  import MrHeckles.Factory

  alias MrHeckles.{Companies, Company}

  describe "list/0" do
    test "returns all existent companies" do
      insert(:company)

      assert companies = Companies.list()
      assert length(companies) == 1
    end
  end

  describe "find/1" do
    test "returns company corresponding to given id" do
      company = insert(:company)

      assert company == Companies.find(company.id)
    end
  end

  describe "create/1" do
    test "returns a struct when params are valid" do
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
