defmodule DestructureTest do
  use ExUnit.Case
  import Destructure
  doctest Destructure

  defmodule Person do
    defstruct [:name, :email]
  end

  alias __MODULE__.Person

  test "destructure a simple structs" do
    d(%Person{name}) = %Person{name: "Joe"}
    assert name == "Joe"
  end

  test "destructure a simple struct with custom variable naming" do
    d(%Person{name, email: mail}) = %Person{name: "Joe", email: "email@example.com"}
    assert {name, mail} == {"Joe", "email@example.com"}
  end
end
