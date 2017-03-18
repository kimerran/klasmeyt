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
    field :score, :integer, virtual: true
    field :price_in_cur, :string, virtual: true
    timestamps()
  end

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, ~w(title price short_desc img_url email mobile fb_profile), [])
  end

  def generate_terms(title, short_desc) do
    "#{title} #{short_desc}"
    |> String.downcase
    |> String.split
    |> Enum.sort
    |> Enum.dedup
  end

  def add_hash_id(model) do
    %{model | hash_id: Api.hasher() |> Hashids.encode(model.id)} 
  end

  def add_terms(model) do
    %{model | terms: generate_terms(model.title, model.short_desc)}
  end

  def add_price_in_cur(model) do
    %{model | price_in_cur: CurrencyFormatter.format(model.price * 100, :php)}
  end

  def search_score(model, query) do
    # loop the search strings
    queries = String.downcase(query) |> String.split()

    score = Enum.reduce(queries, 0,
      fn(q, acc) ->
        if Enum.member?(model.terms, q) do
          acc + 1
        else
          acc
        end
      end)

    %{model | score: score}
  end
end