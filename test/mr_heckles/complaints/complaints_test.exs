defmodule MrHeckles.ComplaintsTest do
  use MrHeckles.DataCase

  import MrHeckles.Factory

  alias MrHeckles.Complaints

  describe "complaints" do
    alias MrHeckles.{Companies.Company, Complaints.Complaint}

    @valid_attrs %{
      city: "some city",
      country: "some country",
      description: "some description",
      latitude: "some latitude",
      longitude: "some longitude",
      state: "some state",
      title: "some title"
    }
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

    def complaint_fixture(_attrs \\ %{}) do
      insert(:complaint)
    end

    test "list_complaints/1 returns all complaints" do
      %Complaint{id: id} = complaint_fixture()
      assert [%Complaint{id: ^id}] = Complaints.list_complaints()
    end

    test "list_complaints/1 returns complaints filtered by city" do
      %Complaint{id: id, city: city} = complaint_fixture()
      assert [%Complaint{id: ^id, city: ^city}] = Complaints.list_complaints(%{"city" => city})
      assert [] = Complaints.list_complaints(%{"city" => "Another city"})
    end

    test "list_complaints/1 returns complaints filtered by company_id" do
      %Complaint{id: id, company_id: company_id} = complaint_fixture()
      assert [%Complaint{id: ^id}] = Complaints.list_complaints(%{"company_id" => company_id})
      assert [] = Complaints.list_complaints(%{"company_id" => company_id + 1})
    end

    test "list_complaints/1 returns complaints filtered by country" do
      %Complaint{id: id, country: country} = complaint_fixture()

      assert [%Complaint{id: ^id, country: ^country}] =
               Complaints.list_complaints(%{"country" => country})

      assert [] = Complaints.list_complaints(%{"country" => "Another country"})
    end

    test "list_complaints/1 returns complaints filtered by state" do
      %Complaint{id: id, state: state} = complaint_fixture()

      assert [%Complaint{id: ^id, state: ^state}] =
               Complaints.list_complaints(%{"state" => state})

      assert [] = Complaints.list_complaints(%{"state" => "Another state"})
    end

    test "get_complaint!/1 returns the complaint with given id" do
      %Complaint{id: id} = complaint_fixture()
      assert %Complaint{id: ^id} = Complaints.get_complaint!(id)
    end

    test "create_complaint/1 with valid data creates a complaint" do
      %Company{id: company_id} = insert(:company)

      assert {:ok, %Complaint{} = complaint} =
               Complaints.create_complaint(Map.merge(@valid_attrs, %{company_id: company_id}))

      assert complaint.city == "some city"
      assert complaint.country == "some country"
      assert complaint.description == "some description"
      assert complaint.state == "some state"
      assert complaint.title == "some title"
      assert complaint.company_id == company_id
    end

    test "create_complaint/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Complaints.create_complaint(@invalid_attrs)
      assert {:error, %Ecto.Changeset{}} = Complaints.create_complaint()
    end

    test "update_complaint/2 with valid data updates the complaint" do
      complaint = complaint_fixture()

      assert {:ok, %Complaint{} = complaint} =
               Complaints.update_complaint(complaint, @update_attrs)

      assert complaint.city == "some updated city"
      assert complaint.country == "some updated country"
      assert complaint.description == "some updated description"
      assert complaint.state == "some updated state"
      assert complaint.title == "some updated title"
    end

    test "update_complaint/2 with invalid data returns error changeset" do
      %Complaint{id: id} = complaint = complaint_fixture()
      assert {:error, %Ecto.Changeset{}} = Complaints.update_complaint(complaint, @invalid_attrs)
      assert %Complaint{id: ^id} = Complaints.get_complaint!(id)
    end

    test "delete_complaint/1 deletes the complaint" do
      complaint = complaint_fixture()
      assert {:ok, %Complaint{}} = Complaints.delete_complaint(complaint)
      assert_raise Ecto.NoResultsError, fn -> Complaints.get_complaint!(complaint.id) end
    end

    test "change_complaint/1 returns a complaint changeset" do
      complaint = complaint_fixture()
      assert %Ecto.Changeset{} = Complaints.change_complaint(complaint)
    end
  end
end
