defmodule LogLevelTest do
  use ExUnit.Case

  test "LogLevel.to_label/2 level 0 has label trace only in a non-legacy app" do
    assert LogLevel.to_label(0, false) == :trace
    assert LogLevel.to_label(0, true) == :unknown
  end

  test "LogLevel.to_label/2 level 1 has label debug" do
    assert LogLevel.to_label(1, false) == :debug
    assert LogLevel.to_label(1, true) == :debug
  end

  test "LogLevel.to_label/2 level 2 has label info" do
    assert LogLevel.to_label(2, false) == :info
    assert LogLevel.to_label(2, true) == :info
  end

  test "LogLevel.to_label/2 level 3 has label warning" do
    assert LogLevel.to_label(3, false) == :warning
    assert LogLevel.to_label(3, true) == :warning
  end

  test "LogLevel.to_label/2 level 4 has label error" do
    assert LogLevel.to_label(4, false) == :error
    assert LogLevel.to_label(4, true) == :error
  end

  test "LogLevel.to_label/2 level 5 has label fatal only in a non-legacy app" do
    assert LogLevel.to_label(5, false) == :fatal
    assert LogLevel.to_label(5, true) == :unknown
  end

  test "LogLevel.to_label/2 level 6 has label unknown" do
    assert LogLevel.to_label(6, false) == :unknown
    assert LogLevel.to_label(6, true) == :unknown
  end

  test "LogLevel.to_label/2 level -1 has label unknown" do
    assert LogLevel.to_label(-1, false) == :unknown
    assert LogLevel.to_label(-1, true) == :unknown
  end

  # ----------------------------------------------------------------------------

  test "LogLevel.alert_recipient/2 fatal code sends alert to ops" do
    assert LogLevel.alert_recipient(5, false) == :ops
  end

  test "LogLevel.alert_recipient/2 error code sends alert to ops" do
    assert LogLevel.alert_recipient(4, false) == :ops
    assert LogLevel.alert_recipient(4, true) == :ops
  end

  test "LogLevel.alert_recipient/2 unknown code sends alert to dev team 1 for a legacy app" do
    assert LogLevel.alert_recipient(6, true) == :dev1
    assert LogLevel.alert_recipient(0, true) == :dev1
    assert LogLevel.alert_recipient(5, true) == :dev1
  end

  test "LogLevel.alert_recipient/2 unknown code sends alert to dev team 2" do
    assert LogLevel.alert_recipient(6, false) == :dev2
  end

  test "LogLevel.alert_recipient/2 trace code does not send alert" do
    assert LogLevel.alert_recipient(0, false) == false
  end

  test "LogLevel.alert_recipient/2 debug code does not send alert" do
    assert LogLevel.alert_recipient(1, false) == false
    assert LogLevel.alert_recipient(1, true) == false
  end

  test "LogLevel.alert_recipient/2 info code does not send alert" do
    assert LogLevel.alert_recipient(2, false) == false
    assert LogLevel.alert_recipient(2, true) == false
  end

  test "LogLevel.alert_recipient/2 warning code does not send alert" do
    assert LogLevel.alert_recipient(3, false) == false
    assert LogLevel.alert_recipient(3, true) == false
  end
end
