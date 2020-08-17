defmodule MrHecklesWeb.ComplaintView do
  use MrHecklesWeb, :view
  alias MrHecklesWeb.ComplaintView

  def render("index.json", %{complaints: complaints}) do
    %{data: render_many(complaints, ComplaintView, "complaint.json")}
  end

  def render("show.json", %{complaint: complaint}) do
    %{data: render_one(complaint, ComplaintView, "complaint.json")}
  end

  def render("complaint.json", %{complaint: complaint}) do
    %{
      id: complaint.id,
      title: complaint.title,
      description: complaint.description,
      city: complaint.city,
      state: complaint.state,
      country: complaint.country,
      latitude: complaint.latitude,
      longitude: complaint.longitude
    }
  end
end
