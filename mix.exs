defmodule VBT.Credo.MixProject do
  use Mix.Project

  def project do
    [
      app: :vbt,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases(),
      preferred_cli_env: preferred_cli_env(),
      dialyzer: dialyzer(),
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix] ++ Mix.compilers()
    ]
  end

  def application do
    additional_apps = if Mix.env() == :test, do: [:postgrex, :ecto], else: []

    [
      extra_applications: [:logger | additional_apps],
      mod: {VBT.Application, []}
    ]
  end

  defp deps do
    [
      {:absinthe_phoenix, "~> 1.4"},
      {:absinthe_plug, "~> 1.4"},
      {:absinthe_relay, "~> 1.4"},
      {:absinthe, "~> 1.4"},
      {:bamboo, "~> 1.4"},
      {:bcrypt_elixir, "~> 2.0"},
      {:credo, "~> 1.1", runtime: false},
      {:dialyxir, "~> 0.5", runtime: false},
      {:ecto_enum, "~> 1.3"},
      {:ecto, "~> 3.0"},
      {:ex_aws, "~> 2.1"},
      {:ex_doc, "~> 0.21", only: :dev, runtime: false},
      {:oban, "~> 1.0"},
      {:parent, "~> 0.8"},
      {:phoenix_html, "~> 2.0"},
      {:phoenix, "~> 1.4"},
      {:stream_data, "~> 0.4", only: [:test, :dev]}
    ]
  end

  defp aliases do
    [
      credo: ~w/compile credo/,
      "ecto.reset": ~w/ecto.drop ecto.create/,
      test: ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end

  defp preferred_cli_env do
    [
      credo: :test,
      dialyzer: :test,
      "ecto.reset": :test,
      "ecto.migrate": :test,
      "ecto.rollback": :test,
      "ecto.gen.migration": :test
    ]
  end

  defp dialyzer() do
    [
      plt_add_apps: ~w/mix eex ecto credo bamboo ex_unit phoenix_pubsub/a
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]
end
