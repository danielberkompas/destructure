defmodule Destructure do
  @moduledoc """
  Provides helpers for destructuring Elixir data structures. See the `d/1` macro
  for more information.
  """

  @doc """
  Easy destructuring of `map`, `structs`, `keyword`, with atom keys.
  String keys are supported via a special syntax `d(s%{param})`.

  ## Examples

  The macro can be used in simple match statements:

      iex> d(%{name}) = %{name: "Joe"}
      ...> name
      "Joe"

  Or in case/for/with statements.

      iex> case %{name: "Mike"} do
      ...>   d%{name} -> name
      ...> end
      "Mike"

  It can be used inside a complex match:

      iex> %{body: d%{name}} = %{body: %{name: "Robert"}}
      ...> name
      "Robert"

  With multiple keys:

      iex> d(%{first, last}) = %{first: "Daniel", last: "Berkompas"}
      ...> {first, last}
      {"Daniel", "Berkompas"}

  With multiple keys and custom variable naming:

      iex> d(%{first, last, email: mail}) = %{first: "Daniel", last: "Berkompas", email: "top@secret.com"}
      ...> {first, last, mail}
      {"Daniel", "Berkompas", "top@secret.com"}

  For Maps with String Keys:

      iex> d(s%{name}) = %{"name" => "Daniel Berkompas"}
      ...> name
      "Daniel Berkompas"

  With multiple keys:

      iex> d(s%{name, email}) = %{"name" => "Daniel Berkompas", "email" => "top@secret.com"}
      ...> {name, email}
      {"Daniel Berkompas", "top@secret.com"}

  With multiple keys and custom variable naming:

      iex> d(s%{name, "email" => mail}) = %{"name" => "Daniel Berkompas", "email" => "top@secret.com"}
      ...> {name, mail}
      {"Daniel Berkompas", "top@secret.com"}


  For structs:

      iex> d(%Person{name}) = %Person{name: "Daniel Berkompas"}
      ...> name
      "Daniel Berkompas"

  With multiple keys:

      iex> d(%Person{name, email}) = %Person{name: "Daniel Berkompas", email: "top@secret.com"}
      ...> {name, email}
      {"Daniel Berkompas", "top@secret.com"}

  With multiple keys and custom variable naming:

      iex> d(%Person{name, email: mail}) = %Person{name: "Daniel Berkompas", email: "top@secret.com"}
      ...> {name, mail}
      {"Daniel Berkompas", "top@secret.com"}

  For keyword lists:

      iex> d([name]) = [name: "Daniel"]
      ...> name
      "Daniel"

  With multiple keys:

      iex> d([first, last]) = [first: "Daniel", last: "Berkompas"]
      ...> [first, last]
      ["Daniel", "Berkompas"]

  With multiple keys and custom assignment:

      iex> d([first, last, email: mail]) = [first: "Daniel", last: "Berkompas", email: "top@secret.com"]
      ...> [first, last, mail]
      ["Daniel", "Berkompas", "top@secret.com"]

  And in function definitions:

      iex> defmodule Test do
      ...>   import Destructure
      ...>   def test(d%{name}) do
      ...>     name
      ...>   end
      ...> end
      ...> Test.test(%{name: "Daniel"})
      "Daniel"
  """
  # Handle maps, including ones with multiple keys
  # {%{}, [], [{:first, [], Elixir}, {:second, [], Elixir}]}
  defmacro d({:%{}, context, args}) do
    {:%{}, context, Enum.map(args, &pattern/1)}
  end

  # Handle string maps, including ones with multiple keys
  # {:s, [], [{:%{}, [], [{:stuff, [], Elixir}, {:things, [], Elixir}]}]}
  defmacro d({:s, _, [{:%{}, context, args}]}) do
    {:%{}, context, Enum.map(args, &s_pattern/1)}
  end

  # Handle structs, including ones with multiple keys
  # {:%, [],
  #  [{:__aliases__, [alias: false], [:Namespace]},
  #   {:%{}, [], [{:first, [], Elixir}, {:second, [], Elixir}]}]}
  defmacro d({:%, x_context, [namespace, {:%{}, y_context, args}]}) do
    {:%, x_context, [namespace, {:%{}, y_context, Enum.map(args, &pattern/1)}]}
  end

  # Handle 1 and 3+ element tuples
  # {:{}, [], [{:first, [], Elixir}]}
  defmacro d({:{}, _, args}) do
    Enum.map(args, &pattern/1)
  end

  # Handle the special case of two-element tuples, whose ASTs look like
  # {{:first, [], Elixir}, {:last, [], Elixir}}
  defmacro d({first, second}) do
    [pattern(first), pattern(second)]
  end

  # Handle keyword list using square bracket
  defmacro d(list) when is_list(list) do
    Enum.map(list, &pattern/1)
  end

  defp s_pattern({key, _, _} = variable) do
    {key |> Atom.to_string(), variable}
  end

  defp s_pattern(otherwise), do: pattern(otherwise)

  defp pattern({key, _, _} = variable) do
    {key, variable}
  end

  defp pattern([arg]) do
    arg
  end

  defp pattern(other) do
    other
  end
end
