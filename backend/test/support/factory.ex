defmodule MrHeckles.Factory do
  @moduledoc """
  Factories to be used in the tests.
  """
  use ExMachina.Ecto, repo: MrHeckles.Repo

  alias MrHeckles.Companies.Company
  alias MrHeckles.Complaints.Complaint

  def company_factory do
    %Company{
      name: sequence(:name, &"Company #{&1}"),
      description: sequence(:description, &"Description of company #{&1}")
    }
  end

  def complaint_factory do
    %Complaint{
      title: sequence(:title, &"Complaint #{&1}"),
      city: "Curitiba",
      state: "Paraná",
      country: "Brasil",
      company: build(:company)
    }
  end
end
