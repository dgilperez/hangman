defmodule GameWorkbench.Mixfile do
  use Mix.Project

  def project do
    [
      app: :game_workbench,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      # text_client: [github: 'dgilperez/text_client'],
      text_client: [path: '../text_client'],
      benchfella: "~> 0.3.0",
    ]
  end
end
