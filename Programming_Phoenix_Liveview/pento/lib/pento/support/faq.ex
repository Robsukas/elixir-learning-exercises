defmodule Pento.Support.FAQ do
  use Ecto.Schema
  import Ecto.Changeset

  schema "faqs" do
    field :question, :string
    field :answer, :string
    field :vote_count, :integer, default: 0

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(faq, attrs) do
    faq
    |> cast(attrs, [:question, :answer, :vote_count])
    |> validate_required([:question, :answer])
  end
end
