defmodule Klasmeyt.Image do
  use Klasmeyt.Web, :model

  schema "images" do
    field :file, :string
  end

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, ~w(file))
  end
end