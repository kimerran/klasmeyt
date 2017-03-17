defmodule Klasmeyt.Item do
  use Klasmeyt.Web, :model

  schema "items" do
    field :title, :string
    field :price, :integer
    field :short_desc, :string
    field :img_url, :string
    field :email, :string
    field :mobile, :string
    field :fb_profile, :string

    timestamps()
  end

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, ~w(title price short_desc img_url email mobile fb_profile), [])
  end
end