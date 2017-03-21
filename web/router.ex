defmodule Klasmeyt.Router do
  use Klasmeyt.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Klasmeyt do
    pipe_through :browser # Use the default browser stack

    get "/", ItemController, :index
    get "/new", ItemController, :new
    post "/save", ItemController, :create
    post "/images", ImageController, :create

    get "/search", ItemController, :search
    #get "test", ItemController, :test
    get "/i/:id", ItemController, :view
  end

  # Other scopes may use custom stacks.
  # scope "/api", Klasmeyt do
  #   pipe_through :api
  # end
end
