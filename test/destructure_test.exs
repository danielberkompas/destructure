defmodule DestructureTest do
  use ExUnit.Case

  import Destructure

  defmodule Person do
    defstruct [:name, :email]
  end

  defmodule People do
    defstruct [:people]
  end

  alias __MODULE__.Person

  doctest Destructure

  describe "structs" do
    test "can't match with different structs" do
      refute d(%People{}) == %Person{}
    end

    test "can bind struct alias to a variable" do
      d(%x{}) = %Person{}

      assert x == Person
    end
  end
end
