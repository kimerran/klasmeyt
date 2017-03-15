defmodule Klasmeyt.ItemController do
  use Klasmeyt.Web, :controller

  alias Klasmeyt.Item

  def new(conn, _params) do
    changeset = Item.changeset(%Item{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, _params) do
    
  end

end