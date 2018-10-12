defmodule Modulr.MixProject do
  use Mix.Project

  def project do
    [
      app: :modulr,
      version: "0.1.0",
      description: "Elixir wrapper for the Modulr API",
      package: package(),
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :httpotion]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.18.0", only: :dev, runtime: false},
      {:httpotion, "~> 3.1.0"}
    ]
  end

  defp package do
    [
      maintainers: ["overture8"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/PiggyPot/modulr"}
    ]
  end
end
