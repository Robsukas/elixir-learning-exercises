defmodule TakeANumberTest do
  use ExUnit.Case

  test "starts a new process" do
    pid = TakeANumber.start()
    assert is_pid(pid)
    assert pid != self()
    assert pid != TakeANumber.start()
  end

  # ----------------------------------------------------------------------------

  test "reports its own state" do
    pid = TakeANumber.start()
    send(pid, {:report_state, self()})
    assert_receive 0
  end

  test "does not shut down after reporting its own state" do
    pid = TakeANumber.start()
    send(pid, {:report_state, self()})
    assert_receive 0
    send(pid, {:report_state, self()})
    assert_receive 0
  end

  # ----------------------------------------------------------------------------

  test "gives out a number" do
    pid = TakeANumber.start()
    send(pid, {:take_a_number, self()})
    assert_receive 1
  end

  test "gives out many consecutive numbers" do
    pid = TakeANumber.start()
    send(pid, {:take_a_number, self()})
    assert_receive 1
    send(pid, {:take_a_number, self()})
    assert_receive 2
    send(pid, {:take_a_number, self()})
    assert_receive 3
    send(pid, {:report_state, self()})
    assert_receive 3
    send(pid, {:take_a_number, self()})
    assert_receive 4
    send(pid, {:take_a_number, self()})
    assert_receive 5
    send(pid, {:report_state, self()})
    assert_receive 5
  end

  # ----------------------------------------------------------------------------

  test "stops" do
    pid = TakeANumber.start()
    assert Process.alive?(pid)
    send(pid, {:report_state, self()})
    assert_receive 0
    send(pid, :stop)
    send(pid, {:report_state, self()})
    refute_receive 0
    refute Process.alive?(pid)
  end

  # ----------------------------------------------------------------------------

  test "ignores unexpected messages and keeps working" do
    pid = TakeANumber.start()
    send(pid, :hello?)
    send(pid, "I want to speak with the manager")
    send(pid, {:take_a_number, self()})
    assert_receive 1
    send(pid, {:report_state, self()})
    assert_receive 1
    dirty_hacky_delay_to_ensure_up_to_date_process_info = 200
    :timer.sleep(dirty_hacky_delay_to_ensure_up_to_date_process_info)
    assert Keyword.get(Process.info(pid), :message_queue_len) == 0
  end
end
