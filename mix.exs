defmodule Modulr.MixProject do
  use Mix.Project

  def project do
    [
      app: :modulr,
      version: "0.2.0",
      description: "Elixir wrapper for the Modulr API",
      package: package(),
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.19.0", only: :dev, runtime: false},
      {:httpoison, "~> 1.0"},
      {:timex, "~> 3.1"},
      {:elixir_uuid, "~> 1.2"},
      {:poison, "~> 3.1"}
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
