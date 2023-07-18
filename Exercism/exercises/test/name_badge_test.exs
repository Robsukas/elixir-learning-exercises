defmodule NameBadgeTest do
  use ExUnit.Case

  test "print/3 prints the employee badge with full data" do
    assert NameBadge.print(455, "Mary M. Brown", "MARKETING") == "[455] - Mary M. Brown - MARKETING"
  end

  test "print/3 uppercases the department" do
    assert NameBadge.print(89, "Jack McGregor", "Procurement") == "[89] - Jack McGregor - PROCUREMENT"
  end

  # ----------------------------------------------------------------------------

  test "print/3 prints the employee badge without id" do
    assert NameBadge.print(nil, "Barbara White", "Security") == "Barbara White - SECURITY"
  end

  # ----------------------------------------------------------------------------

  test "print/3 prints the owner badge" do
    assert NameBadge.print(1, "Anna Johnson", nil) == "[1] - Anna Johnson - OWNER"
  end

  test "print/3 prints the owner badge without id" do
    assert NameBadge.print(nil, "Stephen Dann", nil) == "Stephen Dann - OWNER"
  end
end
