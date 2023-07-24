defmodule Username do
  def sanitize(username) do
    Enum.reduce(username, '', fn x, acc ->
      acc ++ case x do
        ?_ -> '_'
        ?ä -> 'ae'
        ?ö -> 'oe'
        ?ß -> 'ss'
        ?ü -> 'ue'
        x when x in ?a..?z -> [x]
        _ -> ''
      end
    end)
  end
end
