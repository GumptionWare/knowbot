defmodule KnowbotWeb.PageControllerTest do
  use KnowbotWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Welcome to KnowBot Admin!"
  end
end
