defmodule Klasmeyt.ItemController do
  use Klasmeyt.Web, :controller
  alias Klasmeyt.Item
  alias Klasmeyt.Image

  def index(conn, _params) do
    items = Repo.all(Item) |> Enum.map(&user_id_to_hashid/1)
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
    {:ok, [id | _]} = hasher() |> Hashids.decode(hash_id)

    item = Repo.get(Klasmeyt.Item, id)
    render conn, "view.html", item: item
  end

  defp hasher() do
    Hashids.new([salt: "klasmeyt!2017", min_len: 6, alphabet: "123456789thequickbrownfoxjumpsoverthelazydog123456789"])
  end

  def user_id_to_hashid(user) do
      %{user | hash_id: hasher() |> Hashids.encode(user.id)} 
  end
end