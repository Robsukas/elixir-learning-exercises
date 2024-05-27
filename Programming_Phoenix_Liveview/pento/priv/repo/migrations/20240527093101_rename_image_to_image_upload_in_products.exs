defmodule Pento.Repo.Migrations.RenameImageToImageUploadInProducts do
  use Ecto.Migration

  def change do
    rename table(:products), :image, to: :image_upload
  end
end
