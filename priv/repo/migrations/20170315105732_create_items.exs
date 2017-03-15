defmodule Klasmeyt.Repo.Migrations.CreateItems do
  use Ecto.Migration

  def change do
    create table(:items) do
      add :title, :string
      add :price, :integer
      add :short_desc, :string
      add :img_url, :string
      add :email, :string
      add :mobile, :string
      add :fb_profile, :string

      timestamps
    end
  end
end