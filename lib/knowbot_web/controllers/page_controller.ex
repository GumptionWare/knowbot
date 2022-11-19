defmodule KnowbotWeb.PageController do
  use KnowbotWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
