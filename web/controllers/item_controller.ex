defmodule Klasmeyt.ItemController do
  use Klasmeyt.Web, :controller
  alias Klasmeyt.Api
  alias Klasmeyt.Item
  alias Klasmeyt.Image

  def index(conn, _params) do
    query =
      from i in Item,
      select: i,
      limit: 8,
      order_by: [desc: :inserted_at]

    items =
      Repo.all(query)
      |> Enum.map(&Item.add_hash_id/1)
      |> Enum.map(&Item.add_price_in_cur/1)
      |> Enum.sort(fn(i1, i2) -> i1.inserted_at > i2.inserted_at end)

    render conn, "index.html", items: items
  end

  def new(conn, _params) do
    changeset = Item.changeset(%Item{}, :invalid)
    image = Image.changeset(%Image{})
    render conn, "new.html", changeset: changeset, image: image
  end

  def create(conn, %{"item" => item_params}) do
    changeset = Item.changeset(%Item{}, item_params)

    case Repo.insert(changeset) do
      {:ok, item} ->
        put_flash(conn, :info, "New item has been saved")

        render conn, "created.html", item: item |> Item.add_hash_id()

      {:error, changeset} ->
        render conn, "new.html", changeset: changeset
    end
  end

  def view(conn, %{"id" => hash_id}) do
    {:ok, [id | _]} =
      Api.hasher()
      |> Hashids.decode(hash_id)

    item =
      Repo.get(Item, id)
      |> Item.add_price_in_cur()

    render conn, "view.html", item: item
  end

  def search(conn, %{"q" => query}) do
    repo_query =
      from i in Item,
      select: i,
      limit: 20

    items =
      Repo.all(repo_query)
      |> Enum.map(&Item.add_hash_id/1)
      |> Enum.map(&Item.add_price_in_cur/1)
      |> Enum.map(&Item.add_terms/1)
      |> Enum.map(fn i -> Item.search_score(i, query) end)
      |> Enum.filter(fn i -> i.score > 0 end)
      |> Enum.sort(fn(i1, i2) -> i1.score > i2.score end)

    render conn, "search.html", items: items, query: query
  end
end