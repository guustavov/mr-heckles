defmodule MrHeckles.ComplaintsTest do
  use MrHeckles.DataCase

  import MrHeckles.Factory

  alias MrHeckles.Complaints

  describe "complaints" do
    alias MrHeckles.{Companies.Company, Complaints.Complaint}

    @update_attrs %{
      city: "some updated city",
      country: "some updated country",
      description: "some updated description",
      latitude: "some updated latitude",
      longitude: "some updated longitude",
      state: "some updated state",
      title: "some updated title"
    }
    @invalid_attrs %{
      city: nil,
      country: nil,
      description: nil,
      latitude: nil,
      longitude: nil,
      state: nil,
      title: nil,
      company_id: nil
    }

    test "list_complaints/1 returns all complaints" do
      %Complaint{id: id} = insert(:complaint)
      assert [%Complaint{id: ^id}] = Complaints.list_complaints()
    end

    test "list_complaints/1 returns complaints filtered by city" do
      %Complaint{id: id, city: city} = insert(:complaint)
      assert [%Complaint{id: ^id, city: ^city}] = Complaints.list_complaints(%{"city" => city})
      assert [] = Complaints.list_complaints(%{"city" => "Another city"})
    end

    test "list_complaints/1 returns complaints filtered by company_id" do
      %Complaint{id: id, company_id: company_id} = insert(:complaint)
      assert [%Complaint{id: ^id}] = Complaints.list_complaints(%{"company_id" => company_id})
      assert [] = Complaints.list_complaints(%{"company_id" => company_id + 1})
    end

    test "list_complaints/1 returns complaints filtered by country" do
      %Complaint{id: id, country: country} = insert(:complaint)

      assert [%Complaint{id: ^id, country: ^country}] =
               Complaints.list_complaints(%{"country" => country})

      assert [] = Complaints.list_complaints(%{"country" => "Another country"})
    end

    test "list_complaints/1 returns complaints filtered by state" do
      %Complaint{id: id, state: state} = insert(:complaint)

      assert [%Complaint{id: ^id, state: ^state}] =
               Complaints.list_complaints(%{"state" => state})

      assert [] = Complaints.list_complaints(%{"state" => "Another state"})
    end

    test "get_complaint!/1 returns the complaint with given id" do
      %Complaint{id: id} = insert(:complaint)
      assert %Complaint{id: ^id} = Complaints.get_complaint!(id)
    end

    test "create_complaint/1 with valid data creates a complaint" do
      %Company{id: company_id} = insert(:company)

      %{city: city, country: country, description: description, state: state, title: title} =
        params = params_for(:complaint)

      assert {:ok, %Complaint{} = complaint} =
               Complaints.create_complaint(Map.merge(params, %{company_id: company_id}))

      assert complaint.city == city
      assert complaint.country == country
      assert complaint.description == description
      assert complaint.state == state
      assert complaint.title == title
      assert complaint.company_id == company_id
    end

    test "create_complaint/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Complaints.create_complaint(@invalid_attrs)
      assert {:error, %Ecto.Changeset{}} = Complaints.create_complaint()
    end

    test "update_complaint/2 with valid data updates the complaint" do
      complaint = insert(:complaint)

      assert {:ok, %Complaint{} = complaint} =
               Complaints.update_complaint(complaint, @update_attrs)

      assert complaint.city == "some updated city"
      assert complaint.country == "some updated country"
      assert complaint.description == "some updated description"
      assert complaint.state == "some updated state"
      assert complaint.title == "some updated title"
    end

    test "update_complaint/2 with invalid data returns error changeset" do
      %Complaint{id: id} = complaint = insert(:complaint)
      assert {:error, %Ecto.Changeset{}} = Complaints.update_complaint(complaint, @invalid_attrs)
      assert %Complaint{id: ^id} = Complaints.get_complaint!(id)
    end

    test "delete_complaint/1 deletes the complaint" do
      complaint = insert(:complaint)
      assert {:ok, %Complaint{}} = Complaints.delete_complaint(complaint)
      assert_raise Ecto.NoResultsError, fn -> Complaints.get_complaint!(complaint.id) end
    end

    test "change_complaint/1 returns a complaint changeset" do
      complaint = insert(:complaint)
      assert %Ecto.Changeset{} = Complaints.change_complaint(complaint)
    end
  end
end
