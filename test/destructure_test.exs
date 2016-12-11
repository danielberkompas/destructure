defmodule DestructureTest do
  use ExUnit.Case

  import Destructure

  defmodule Person do
    defstruct [:name, :email]
  end

  alias __MODULE__.Person

  doctest Destructure
end
