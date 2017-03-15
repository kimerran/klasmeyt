defmodule Klasmeyt.ItemController do
  use Klasmeyt.Web, :controller

  def new(conn, _params) do
    render conn, "new.html"
  end

end