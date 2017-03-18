defmodule Klasmeyt.ItemController do
  use Klasmeyt.Web, :controller
  alias Klasmeyt.Api
  alias Klasmeyt.Item
  alias Klasmeyt.Image

  def index(conn, _params) do
    items =
      Repo.all(Item)
      |> Enum.map(&Item.add_hash_id/1)
      |> Enum.sort(fn(i1, i2) -> i1.updated_at > i2.updated_at end)

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
      {:ok, _item} ->
        conn
        |> put_flash(:info, "New item has been saved")
        |> redirect(to: item_path(conn, :index))
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
      |> Item.add_terms()

    render conn, "view.html", item: item
  end

  def search(conn, %{"q" => query}) do
    items =
    Repo.all(Item)
    |> Enum.map(&Item.add_hash_id/1)
    |> Enum.map(&Item.add_terms/1)
    |> Enum.map(fn i -> Item.search_score(i, query) end)
    |> Enum.filter(fn i -> i.score > 0 end)
    |> Enum.sort(fn(i1, i2) -> i1.score > i2.score end)

    render conn, "search.html", items: items
  end
end