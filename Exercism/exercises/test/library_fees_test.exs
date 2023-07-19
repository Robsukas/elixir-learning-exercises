defmodule LibraryFeesTest do
  use ExUnit.Case

  test "datetime_from_string/1 returns NaiveDateTime" do
    result = LibraryFees.datetime_from_string("2021-01-01T12:00:00Z")
    assert result.__struct__ == NaiveDateTime
  end

  test "datetime_from_string/1 parses an ISO8601 string" do
    result = LibraryFees.datetime_from_string("2019-12-24T13:15:45Z")
    assert result == ~N[2019-12-24 13:15:45Z]
  end

  # ----------------------------------------------------------------------------

  test "before_noon?/1 returns true if the given NaiveDateTime is before 12:00" do
    assert LibraryFees.before_noon?(~N[2020-06-06 11:59:59Z]) == true
  end

  test "before_noon?/1 returns false if the given NaiveDateTime is after 12:00" do
    assert LibraryFees.before_noon?(~N[2021-01-03 12:01:01Z]) == false
  end

  test "before_noon?/1 returns false if the given NaiveDateTime is exactly at 12:00" do
    assert LibraryFees.before_noon?(~N[2018-11-17 12:00:00Z]) == false
  end

  # ----------------------------------------------------------------------------

  test "return_date/1 adds 28 days if the given NaiveDateTime is before 12:00" do
    result = LibraryFees.return_date(~N[2020-02-14 11:59:59Z])
    assert result == ~D[2020-03-13]
  end

  test "return_date/1 adds 29 days if the given NaiveDateTime is after 12:00" do
    result = LibraryFees.return_date(~N[2021-01-03 12:01:01Z])
    assert result == ~D[2021-02-01]
  end

  test "return_date/1 adds 29 days if the given NaiveDateTime is exactly at 12:00" do
    result = LibraryFees.return_date(~N[2018-12-01 12:00:00Z])
    assert result == ~D[2018-12-30]
  end

  # ----------------------------------------------------------------------------

  test "days_late/2 returns 0 when identical datetimes" do
    result = LibraryFees.days_late(~D[2021-02-01], ~N[2021-02-01 12:00:00Z])
    assert result == 0
  end

  test "days_late/2 returns 0 when identical dates, but different times" do
    result = LibraryFees.days_late(~D[2019-03-11], ~N[2019-03-11 12:00:00Z])
    assert result == 0
  end

  test "days_late/2 returns 0 when planned return date is later than actual return date" do
    result = LibraryFees.days_late(~D[2020-12-03], ~N[2020-11-29 16:00:00Z])
    assert result == 0
  end

  test "days_late/2 returns date difference in numbers of days when planned return date is earlier than actual return date" do
    result = LibraryFees.days_late(~D[2020-06-12], ~N[2020-06-21 16:00:00Z])
    assert result == 9
  end

  test "days_late/2 a new day starts at midnight" do
    result = LibraryFees.days_late(~D[2020-06-12], ~N[2020-06-12 23:59:59Z])
    assert result == 0
    result = LibraryFees.days_late(~D[2020-06-12], ~N[2020-06-13 00:00:00Z])
    assert result == 1
  end

  # ----------------------------------------------------------------------------

  test "monday? 2021-02-01 was a Monday" do
    assert LibraryFees.monday?(~N[2021-02-01 14:01:00Z]) == true
  end

  test "monday? 2020-03-16 was a Monday" do
    assert LibraryFees.monday?(~N[2020-03-16 09:23:52Z]) == true
  end

  test "monday? 2020-04-22 was a Monday" do
    assert LibraryFees.monday?(~N[2019-04-22 15:44:03Z]) == true
  end

  test "monday? 2021-02-02 was a Tuesday" do
    assert LibraryFees.monday?(~N[2021-02-02 15:07:00Z]) == false
  end

  test "monday? 2020-03-14 was a Friday" do
    assert LibraryFees.monday?(~N[2020-03-14 08:54:51Z]) == false
  end

  test "monday? 2019-04-28 was a Sunday" do
    assert LibraryFees.monday?(~N[2019-04-28 11:37:12Z]) == false
  end

  # ----------------------------------------------------------------------------

  test "calculate_late_fee/2 returns 0 if the book was returned less than 28 days after a morning checkout" do
    result = LibraryFees.calculate_late_fee("2018-11-01T09:00:00Z", "2018-11-13T14:12:00Z", 123)
    assert result == 0
  end

  test "calculate_late_fee/2 returns 0 if the book was returned exactly 28 days after a morning checkout" do
    result = LibraryFees.calculate_late_fee("2018-11-01T09:00:00Z", "2018-11-29T14:12:00Z", 123)
    assert result == 0
  end

  test "calculate_late_fee/2 returns the rate for one day if the book was returned exactly 29 days after a morning checkout" do
    result = LibraryFees.calculate_late_fee("2018-11-01T09:00:00Z", "2018-11-30T14:12:00Z", 320)
    assert result == 320
  end

  test "calculate_late_fee/2 returns 0 if the book was returned less than 29 days after an afternoon checkout" do
    result = LibraryFees.calculate_late_fee("2019-05-01T16:12:00Z", "2019-05-17T14:32:45Z", 400)
    assert result == 0
  end

  test "calculate_late_fee/2 returns 0 if the book was returned exactly 29 days after an afternoon checkout" do
    result = LibraryFees.calculate_late_fee("2019-05-01T16:12:00Z", "2019-05-30T14:32:45Z", 313)
    assert result == 0
  end

  test "calculate_late_fee/2 returns the rate for one day if the book was returned exactly 30 days after an afternoon checkout" do
    result = LibraryFees.calculate_late_fee("2019-05-01T16:12:00Z", "2019-05-31T14:32:45Z", 234)
    assert result == 234
  end

  test "calculate_late_fee/2 multiplies the number of days late by the rate for one day" do
    result = LibraryFees.calculate_late_fee("2021-01-01T08:00:00Z", "2021-02-13T08:00:00Z", 111)
    assert result == 111 * 15
  end

  test "calculate_late_fee/2 late fees are 50% off (rounded down) when the book is returned on a Monday" do
    result = LibraryFees.calculate_late_fee("2021-01-01T08:00:00Z", "2021-02-15T08:00:00Z", 111)
    assert result == trunc(111 * 17 * 0.5)
  end
end
