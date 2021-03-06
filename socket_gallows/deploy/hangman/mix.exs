defmodule Hangman.Mixfile do
  use Mix.Project

  def project do
    [
      app: :hangman,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: { Hangman.Application, []},
      extra_applications: [
        :logger
      ]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # { :dictionary, github: "dgilperez/dictionary" },
      { :inflex, "~> 1.8.1" },
      { :dictionary, path: '../dictionary' },
    ]
  end
end
