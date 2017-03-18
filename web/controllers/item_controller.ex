defmodule Klasmeyt.ItemController do
  use Klasmeyt.Web, :controller
  alias Klasmeyt.Api
  alias Klasmeyt.Item
  alias Klasmeyt.Image

  def index(conn, _params) do
    items = Repo.all(Item) |> Enum.map(&Item.add_hash_id/1)
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
end