defmodule Mix.Tasks.MakeAdmin do
  use Mix.Task
  alias Pento.Repo
  alias Pento.Accounts.User

  @shortdoc "Make a user an admin"
  def run([email]) do
    Mix.Task.run("app.start")

    case Repo.get_by(User, email: email) do
      nil ->
        IO.puts("User not found")

      user ->
        user
        |> Ecto.Changeset.change(%{is_admin: true})
        |> Repo.update!()

        IO.puts("User #{email} is now an admin")
    end
  end

  def run(_) do
    IO.puts("Usage: mix make_admin <email>")
  end
end
