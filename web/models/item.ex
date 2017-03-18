defmodule Klasmeyt.Item do
  use Klasmeyt.Web, :model
  alias Klasmeyt.Api

  schema "items" do
    field :title, :string
    field :price, :integer
    field :short_desc, :string
    field :img_url, :string
    field :email, :string
    field :mobile, :string
    field :fb_profile, :string

    field :hash_id, :string, virtual: true
    field :terms, :string, virtual: true
    timestamps()
  end

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, ~w(title price short_desc img_url email mobile fb_profile), [])
  end

  def add_hash_id(model) do
    %{model | hash_id: Api.hasher() |> Hashids.encode(model.id)} 
  end

  def add_terms(model) do
    %{model | terms: Api.generate_terms(model.title, model.short_desc)}
  end
end