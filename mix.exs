defmodule Destructure.Mixfile do
  use Mix.Project

  def project do
    [app: :destructure,
     version: "0.2.2",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     source_url: "https://github.com/danielberkompas/destructure",
     description: "Javascript-style destructuring for Elixir",
     package: package(),
     docs: docs(),
     deps: deps()]
  end

  def application do
    [applications: [:logger]]
  end

  defp deps do
    [{:ex_doc, ">= 0.0.0", only: :dev}]
  end

  defp docs do
    [
      readme: "README.md",
      main: Destructure
    ]
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README.md", "CHANGELOG.md", "LICENSE"],
      maintainers: ["Daniel Berkompas"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/danielberkompas/destructure"
      }
    ]
  end
end
