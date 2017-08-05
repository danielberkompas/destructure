# Destructure
[![Hex.pm](https://img.shields.io/hexpm/v/destructure.svg)](https://hex.pm/packages/destructure)
[![Build Status](https://travis-ci.org/danielberkompas/destructure.svg?branch=master)](https://travis-ci.org/danielberkompas/destructure)

Adds Javascript-style destructuring to Elixir. When working with `map`, instead
of writing match operation like this:

```elixir
def full_name(%{first_name: first_name, last_name: last_name}) do
  "#{first_name} #{last_name}"
end
```

You can write:

```elixir
import Destructure

def full_name(d%{first_name, last_name}) do
  "#{first_name} #{last_name}"
end
```

It also works with `structs` and `keyword`.

```elixir
import Destructure

def full_name(d%Person{first_name, last_name}) do
  "#{first_name} #{last_name}"
end
def full_name(d[first_name, last_name]) do
  "#{first_name} #{last_name}"
end
```

You can also do it in case statement.

```elixir
case post(url, data) do
  {:ok, d%{body}} -> # instead of {:ok, %{body: body}}
    # use body variable
  _other ->
    # ...
end
```

Unlike Javascript, you can still bind custom variables:

```elixir
d(%{first, last, email: mail}) = %{...}
```

See the [Hex Documentation](https://hexdocs.pm/destructure) for more details.

## Installation

Add `destructure` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:destructure, "~> 0.2.3"}]
end
```
