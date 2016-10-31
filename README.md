# Destructure

Adds Javascript-style destructuring to Elixir. Instead of:

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

See the [Hex Documentation]() for more details.

## Installation

  1. Add `destructure` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:destructure, "~> 0.1.0"}]
    end
    ```

  2. Ensure `destructure` is started before your application:

    ```elixir
    def application do
      [applications: [:destructure]]
    end
    ```
