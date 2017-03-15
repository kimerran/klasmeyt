defmodule Klasmeyt.PageController do
  use Klasmeyt.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
