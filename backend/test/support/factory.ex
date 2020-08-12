defmodule MrHeckles.Factory do
  @moduledoc """
  Factories to be used in the tests.
  """
  use ExMachina.Ecto, repo: MrHeckles.Repo

  alias MrHeckles.Companies.Company

  def company_factory do
    %Company{
      name: sequence(:name, &"Company #{&1}"),
      description: sequence(:description, &"Description of company #{&1}")
    }
  end
end
