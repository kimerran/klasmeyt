defmodule Klasmeyt.ImageView do
  use Klasmeyt.Web, :view

  def render("create.json", params) do
    %{:conn => %{:assigns => %{img_filename: fname}}} = params
    %{filename: fname}
  end
end