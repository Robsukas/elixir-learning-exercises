defmodule Pento.Repo.Migrations.AddVoteCountDefaultToFaqs do
  use Ecto.Migration

  def change do
    alter table(:faqs) do
      modify :vote_count, :integer, default: 0
    end
  end
end
