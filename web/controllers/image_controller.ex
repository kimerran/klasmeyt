defmodule Klasmeyt.ImageController do
  use Klasmeyt.Web, :controller

  def create(conn, %{"image" => %{"file" => image}}) do
    # todo: should only accepts valid image files
    # todo: should resize image if too large

    File.cp(image.path, "/home/mhneri/tmp/#{image.filename}")
  end
end