defmodule Klasmeyt.ItemController do
  use Klasmeyt.Web, :controller
  alias Klasmeyt.Item
  alias Klasmeyt.Image

  def index(conn, _params) do
    items = Repo.all(Item)
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
        conn
        |> put_flash(:info, "New item has been saved")
        |> redirect(to: item_path(conn, :index))
      {:error, changeset} ->
        render conn, "new.html", changeset: changeset
    end
  end

  def view(conn, %{"id" => id}) do
    item = Repo.get(Klasmeyt.Item, id)
    render conn, "view.html", item: item
  end

end