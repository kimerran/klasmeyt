defmodule Klasmeyt.ImageController do
  use Klasmeyt.Web, :controller

  def create(conn, %{"image" => %{"file" => image}}) do
    IO.puts "++++"
    IO.inspect image
    File.cp(image.path, "/home/mhneri/tmp/#{image.filename}")
  end
end