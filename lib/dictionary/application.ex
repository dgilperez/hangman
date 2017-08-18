defmodule Dictionary.Application do
  use Application

  def start(_, _) do
    Dictionary.WordList.start_link
  end
end
