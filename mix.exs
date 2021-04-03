defmodule Weather.MixProject do
  use Mix.Project

  def project do
    [
      app: :weather,
      version: "0.1.0",
      escript: escript_config(),
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      name: "Weather",
      source_url: "https://github.com/danielvu1994/PE_1_6_weather_ex",
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
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:httpoison, "~> 1.8.0"},
      {:poison, "~> 3.1"},
      {:ex_doc, "~> 0.19"},
      {:earmark, "~> 1.4.10"},
      {:elixml, github: "mlankenau/elixml"},
      {:elixir_xml_to_map, "~> 2.0.0"}
    ]
  end

  defp escript_config do
    [
      main_module: Weather.CLI
    ]
  end
end
