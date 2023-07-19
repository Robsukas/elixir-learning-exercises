defmodule BirdCountTest do
  use ExUnit.Case

  test "today/1 returns nil if no bird watching data recorded" do
    assert BirdCount.today([]) == nil
  end

  test "today/1 returns today's bird count" do
    assert BirdCount.today(~c"\a") == 7
    assert BirdCount.today([2, 4, 11, 10, 6, 8]) == 2
  end

  # ----------------------------------------------------------------------------

  test "increment_day_count/1 creates entry for today if no bird watching data recorded" do
    assert BirdCount.increment_day_count([]) == [1]
  end

  test "increment_day_count/1 adds 1 to today's bird count" do
    assert BirdCount.increment_day_count(~c"\a") == ~c"\b"
    assert BirdCount.increment_day_count([4, 2, 1, 0, 10]) == [5, 2, 1, 0, 10]
  end

  # ----------------------------------------------------------------------------

  test "has_day_without_birds?/1 false if no bird watching data recorded" do
    assert BirdCount.has_day_without_birds?([]) == false
  end

  test "has_day_without_birds?/1 false if there are no zeros in bird watching data" do
    assert BirdCount.has_day_without_birds?([1]) == false
    assert BirdCount.has_day_without_birds?([6, 7, 10, 2, 5]) == false
  end

  test "has_day_without_birds?/1 true if there are is at least one zero in bird watching data" do
    assert BirdCount.has_day_without_birds?([0]) == true
    assert BirdCount.has_day_without_birds?([4, 4, 0, 1]) == true
    assert BirdCount.has_day_without_birds?([0, 0, 3, 0, 5, 6, 0]) == true
  end

  # ----------------------------------------------------------------------------

  test "total/1 zero if no bird watching data recorded" do
    assert BirdCount.total([]) == 0
  end

  test "total/1 sums up bird counts" do
    assert BirdCount.total([4]) == 4
    assert BirdCount.total([3, 0, 0, 4, 4, 0, 0, 10]) == 21
  end

  # ----------------------------------------------------------------------------

  test "busy_days/1 zero if no bird watching data recorded" do
    assert BirdCount.busy_days([]) == 0
  end

  test "busy_days/1 counts days with bird count of 5 or more" do
    assert BirdCount.busy_days([1]) == 0
    assert BirdCount.busy_days([0, 5]) == 1
    assert BirdCount.busy_days([0, 6, 10, 4, 4, 5, 0]) == 3
  end
end
