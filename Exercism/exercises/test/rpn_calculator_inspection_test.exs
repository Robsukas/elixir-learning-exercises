defmodule RPNCalculatorInspectionTest do
  use ExUnit.Case

  test "start_reliability_check returns a map with test data" do
    calculator = fn _ -> 0 end
    input = "1 2 +"
    result = RPNCalculatorInspection.start_reliability_check(calculator, input)
    assert is_map(result)
    assert is_pid(result.pid)
    assert result.input == input
  end

  test "start_reliability_check starts a linked process" do
    old_value = Process.flag(:trap_exit, true)
    calculator = fn _ -> :timer.sleep(50) end
    input = "1 2 +"
    %{pid: pid} = RPNCalculatorInspection.start_reliability_check(calculator, input)
    assert pid in Keyword.get(Process.info(self()), :links)
    assert_receive {:EXIT, ^pid, :normal}
    Process.flag(:trap_exit, old_value)
  end

  test "start_reliability_check the process runs the calculator function with the given input" do
    caller_process_pid = self()
    calculator = fn input -> send(caller_process_pid, input) end
    input = "7 3 +"
    RPNCalculatorInspection.start_reliability_check(calculator, input)
    assert_receive ^input
  end

  # ----------------------------------------------------------------------------

  test "await_reliability_check_result adds `input` => :ok to the results after a normal exit" do
    caller_process_pid = self()
    test_data = %{pid: caller_process_pid, input: "2 3 +"}
    check_results_so_far = %{"2 0 /" => :error}
    expected_result = %{"2 0 /" => :error, "2 3 +" => :ok}
    send(caller_process_pid, {:EXIT, caller_process_pid, :normal})

    assert RPNCalculatorInspection.await_reliability_check_result(
             test_data,
             check_results_so_far
           ) == expected_result
  end

  test "await_reliability_check_result adds `input` => :error to the results after an abnormal exit" do
    caller_process_pid = self()
    test_data = %{pid: caller_process_pid, input: "3 0 /"}
    check_results_so_far = %{"1 1 +" => :ok}
    expected_result = %{"1 1 +" => :ok, "3 0 /" => :error}
    send(caller_process_pid, {:EXIT, caller_process_pid, {%ArithmeticError{}, []}})

    assert RPNCalculatorInspection.await_reliability_check_result(
             test_data,
             check_results_so_far
           ) == expected_result
  end

  test "await_reliability_check_result adds `input` => :timeout to the results if no message arrives in 100ms" do
    caller_process_pid = self()
    test_data = %{pid: caller_process_pid, input: "24 12 /"}
    check_results_so_far = %{"3 1 +" => :ok}
    expected_result = %{"3 1 +" => :ok, "24 12 /" => :timeout}

    task =
      Task.async(fn ->
        :timer.sleep(200)
        send(caller_process_pid, {:EXIT, caller_process_pid, {%ArithmeticError{}, []}})
      end)

    assert RPNCalculatorInspection.await_reliability_check_result(
             test_data,
             check_results_so_far
           ) == expected_result

    Task.await(task)
  end

  test "await_reliability_check_result normal exit messages from processes whose pids don't match stay in the inbox" do
    caller_process_pid = self()
    other_process_pid = spawn(fn -> nil end)
    test_data = %{pid: caller_process_pid, input: "5 0 /"}
    check_results_so_far = %{"5 0 +" => :ok}
    expected_result = %{"5 0 +" => :ok, "5 0 /" => :error}
    send(caller_process_pid, {:EXIT, other_process_pid, :normal})
    send(caller_process_pid, {:EXIT, caller_process_pid, {%ArithmeticError{}, []}})

    assert RPNCalculatorInspection.await_reliability_check_result(
             test_data,
             check_results_so_far
           ) == expected_result

    assert Keyword.get(Process.info(self()), :message_queue_len) == 1
  end

  test "await_reliability_check_result abnormal exit messages from processes whose pids don't match stay in the inbox" do
    caller_process_pid = self()
    other_process_pid = spawn(fn -> nil end)
    test_data = %{pid: caller_process_pid, input: "2 2 +"}
    check_results_so_far = %{"0 0 /" => :error}
    expected_result = %{"0 0 /" => :error, "2 2 +" => :ok}
    send(caller_process_pid, {:EXIT, other_process_pid, {%ArithmeticError{}, []}})
    send(caller_process_pid, {:EXIT, caller_process_pid, :normal})

    assert RPNCalculatorInspection.await_reliability_check_result(
             test_data,
             check_results_so_far
           ) == expected_result

    assert Keyword.get(Process.info(self()), :message_queue_len) == 1
  end

  test "await_reliability_check_result any other messages stay in the inbox" do
    caller_process_pid = self()
    test_data = %{pid: caller_process_pid, input: "4 2 /"}
    check_results_so_far = %{"4 0 /" => :error}
    expected_result = %{"4 0 /" => :error, "4 2 /" => :ok}
    send(caller_process_pid, {:exit, caller_process_pid, {%ArithmeticError{}, []}})
    send(caller_process_pid, {:something_else, caller_process_pid, {%ArithmeticError{}, []}})
    send(caller_process_pid, :something_else)
    send(caller_process_pid, {:EXIT, caller_process_pid, :normal})

    assert RPNCalculatorInspection.await_reliability_check_result(
             test_data,
             check_results_so_far
           ) == expected_result

    assert Keyword.get(Process.info(self()), :message_queue_len) == 3
  end

  test "await_reliability_check_result doesn't change the trap_exit flag of the caller process" do
    caller_process_pid = self()
    Process.flag(:trap_exit, false)
    test_data = %{pid: caller_process_pid, input: "30 3 /"}
    check_results_so_far = %{}
    expected_result = %{"30 3 /" => :ok}
    send(caller_process_pid, {:EXIT, caller_process_pid, :normal})

    assert RPNCalculatorInspection.await_reliability_check_result(
             test_data,
             check_results_so_far
           ) == expected_result

    assert Keyword.get(Process.info(self()), :trap_exit) == false
    Process.flag(:trap_exit, true)
    send(caller_process_pid, {:EXIT, caller_process_pid, :normal})

    assert RPNCalculatorInspection.await_reliability_check_result(
             test_data,
             check_results_so_far
           ) == expected_result

    assert Keyword.get(Process.info(self()), :trap_exit) == true
  end

  # ----------------------------------------------------------------------------

  test "reliability_check returns an empty map when input list empty" do
    inputs = []
    calculator = fn x -> x end
    outputs = %{}
    assert RPNCalculatorInspection.reliability_check(calculator, inputs) == outputs
  end

  test "reliability_check returns a map with inputs as keys and :ok as values" do
    inputs = ["4 2 /", "8 2 /", "6 3 /"]
    calculator = fn _ -> :ok end
    outputs = %{"4 2 /" => :ok, "8 2 /" => :ok, "6 3 /" => :ok}
    assert RPNCalculatorInspection.reliability_check(calculator, inputs) == outputs
  end

  # ----------------------------------------------------------------------------

  test "correctness_check returns an empty list when input list empty" do
    inputs = []
    calculator = fn x -> x end
    outputs = []
    assert RPNCalculatorInspection.correctness_check(calculator, inputs) == outputs
  end

  test "correctness_check awaits a single task for 100ms" do
    inputs = ["1 1 /1"]
    calculator = fn _ -> :timer.sleep(500) end
    Process.flag(:trap_exit, true)
    pid = spawn_link(fn -> RPNCalculatorInspection.correctness_check(calculator, inputs) end)

    assert_receive {:EXIT, ^pid, {:timeout, {Task, task_fn, [_task, 100]}}}
                   when task_fn in [:await, :await_many],
                   150,
                   "expected to receive a timemout message from Task.await/2 or Task.await_many/2"

    Process.flag(:trap_exit, false)
  end
end
