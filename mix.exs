defmodule TheElixir.Mixfile do
  use Mix.Project

  def project do
    [app: :the_elixir,
     version: "0.1.0",
     elixir: "~> 1.8.0",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [extra_applications: [:logger, :postgrex, :ecto],
     mod: {TheElixir.Application, []}]
  end

  # Dependencies can be Hex packages:
  #
  #   {:my_dep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:postgrex, "~> 0.13"},
      {:ecto_sql, "~> 3.0"},
      {:poison, "~> 4.0"},
      {:credo, "~> 1.0", only: [:dev, :test], runtime: false}
    ]
  end
end
