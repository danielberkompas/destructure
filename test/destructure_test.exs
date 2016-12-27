defmodule DestructureTest do
  use ExUnit.Case

  import Destructure

  defmodule Person do
    defstruct [:name, :email]
  end

  defmodule People do
    defstruct [:people]
  end

  doctest Destructure

  describe "structs" do
    test "raise MatchError on match with different structs" do
      assert_raise MatchError, fn ->
        d(%People{}) = %Person{}
      end
    end

    test "can bind struct alias to a variable" do
      d(%x{}) = %Person{}

      assert x == Person
    end
  end
end
