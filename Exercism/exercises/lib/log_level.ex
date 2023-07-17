defmodule LogLevel do
  def to_label(level, legacy?) do
    cond do
      level == 0 -> cond do
        legacy? -> :unknown
        !legacy? -> :trace
      end
      level == 1 -> :debug
      level == 2 -> :info
      level == 3 -> :warning
      level == 4 -> :error
      level == 5 -> cond do
        legacy? -> :unknown
        !legacy? -> :fatal
      end
      true -> :unknown
    end
  end

  def alert_recipient(level, legacy?) do
    log = to_label(level, legacy?)

    cond do
      log == :error || log == :fatal -> :ops
      log == :unknown -> cond do
        legacy? -> :dev1
        !legacy? -> :dev2
      end
      true -> :false
    end
  end
end
