defmodule Gallows.PageController do
  use Gallows.Web, :controller

  def index(conn, _params) do
    produce = [{"egg", 12}, {"butter spoon", 2}, {"milk glass", 1}, {"missing item", -5}]
    render conn, "index.html", produce: produce
  end
end
