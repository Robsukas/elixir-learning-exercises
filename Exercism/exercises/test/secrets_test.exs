defmodule SecretsTest do
  use ExUnit.Case

  test "secret_add add 3" do
    add = Secrets.secret_add(3)
    assert add.(3) === 6
  end

  test "secret_add add 6" do
    add = Secrets.secret_add(6)
    assert add.(9) === 15
  end

  # ----------------------------------------------------------------------------

  test "secret_subtract subtract 3" do
    subtract = Secrets.secret_subtract(3)
    assert subtract.(6) === 3
  end

  test "secret_subtract subtract 6" do
    subtract = Secrets.secret_subtract(6)
    assert subtract.(3) === -3
  end

  # ----------------------------------------------------------------------------

  test "secret_multiply multiply by 3" do
    multiply = Secrets.secret_multiply(3)
    assert multiply.(6) === 18
  end

  test "secret_multiply multiply by 6" do
    multiply = Secrets.secret_multiply(6)
    assert multiply.(7) === 42
  end

  # ----------------------------------------------------------------------------

  test "secret_divide divide by 3" do
    divide = Secrets.secret_divide(3)
    assert divide.(6) === 2
  end

  test "secret_divide divide by 6" do
    divide = Secrets.secret_divide(6)
    assert divide.(7) === 1
  end

  # ----------------------------------------------------------------------------

  test "secret_and 2 and 1" do
    ander = Secrets.secret_and(1)
    assert ander.(2) === 0
  end

  test "secret_and 7 and 7" do
    ander = Secrets.secret_and(7)
    assert ander.(7) === 7
  end

  # ----------------------------------------------------------------------------

  test "secret_xor 2 xor 1" do
    xorer = Secrets.secret_xor(1)
    assert xorer.(2) === 3
  end

  test "secret_xor 7 xor 7" do
    xorer = Secrets.secret_xor(7)
    assert xorer.(7) === 0
  end

  # ----------------------------------------------------------------------------

  test "secret_combine 5 add 10 then subtract 5" do
    f = Secrets.secret_add(10)
    g = Secrets.secret_subtract(5)
    h = Secrets.secret_combine(f, g)
    assert h.(5) === 10
  end

  test "secret_combine 100 multiply by 2 then subtract 20" do
    f = Secrets.secret_multiply(2)
    g = Secrets.secret_subtract(20)
    h = Secrets.secret_combine(f, g)
    assert h.(100) === 180
  end

  test "secret_combine 32 divide by 3 then add 5" do
    f = Secrets.secret_divide(3)
    g = Secrets.secret_add(5)
    h = Secrets.secret_combine(f, g)
    assert h.(32) === 15
  end

  test "secret_combine 7 and 7 then and 7" do
    f = Secrets.secret_and(7)
    g = Secrets.secret_and(7)
    h = Secrets.secret_combine(f, g)
    assert h.(7) === 7
  end

  test "secret_combine 7 xor 7 then xor 7" do
    f = Secrets.secret_xor(7)
    g = Secrets.secret_xor(7)
    h = Secrets.secret_combine(f, g)
    assert h.(7) === 7
  end

  test "secret_combine 81 divide by 9 then and 7" do
    f = Secrets.secret_divide(9)
    g = Secrets.secret_and(7)
    h = Secrets.secret_combine(f, g)
    assert h.(81) === 1
  end
end
