defmodule GenserverTest do
  use ExUnit.Case

  test "server_process" do
    {:ok, cache} = Chores.Cache.start()
    bob_pid = Chores.Cache.server_process(cache, "bob")

    assert bob_pid != Chores.Cache.server_process(cache, "alice")
    assert bob_pid == Chores.Cache.server_process(cache, "bob")
  end

  test "chores operations" do
    {:ok, cache} = Chores.Cache.start()
    alice = Chores.Cache.server_process(cache, "alice")
    Chores.Server.add_entry(alice, %{date: ~D[2018-12-19], title: "Dentist"})
    entries = Chores.Server.entries(alice, ~D[2018-12-19])

    assert [%{date: ~D[2018-12-19], title: "Dentist"}] = entries
  end
end
