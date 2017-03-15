defmodule Klasmeyt.ItemController do
  use Klasmeyt.Web, :controller
  alias Klasmeyt.Item

  def index(conn, _params) do
    items = Repo.all(Item)
    render conn, "index.html", items: items
  end

  def new(conn, _params) do
    changeset = Item.changeset(%Item{})
    render conn, "new.html", changeset: changeset
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

end