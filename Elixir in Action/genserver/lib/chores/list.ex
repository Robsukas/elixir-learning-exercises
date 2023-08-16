defmodule Chores.List do
  defstruct auto_id: 1, entries: %{}

  def new(entries \\ []) do
    Enum.reduce(
      entries,
      %Chores.List{},
      &add_entry(&2, &1)
    )
  end

  def size(chores_list) do
    Kernel.map_size(chores_list.entries)
  end

  def add_entry(chores_list, entry) do
    entry = Map.put(entry, :id, chores_list.auto_id)
    new_entries = Map.put(chores_list.entries, chores_list.auto_id, entry)

    %Chores.List{chores_list | auto_id: chores_list.auto_id + 1, entries: new_entries}
  end

  def entries(chores_list, date) do
    chores_list.entries
    |> Stream.filter(fn {_, entry} -> entry.date == date end)
    |> Enum.map(fn {_, entry} -> entry end)
  end

  def update_entry(chores_list, %{} = new_entry) do
    update_entry(chores_list, new_entry.id, fn _ -> new_entry end)
  end

  def update_entry(chores_list, entry_id, entry_update_fun) do
    case Map.fetch(chores_list.entries, entry_id) do
      :error ->
        chores_list
      {:ok, old_entry} ->
        new_entry = entry_update_fun.(old_entry)
        new_entries = Map.put(chores_list.entries, entry_id, new_entry)
        %Chores.List{chores_list | entries: new_entries}
    end
  end

  def delete_entry(chores_list, entry_id) do
    %Chores.List{chores_list | entries: Map.delete(chores_list.entries, entry_id)}
  end
end
