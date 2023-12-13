class AddCoverPhotoToEvents < ActiveRecord::Migration[7.1]
  def change
    add_column :events, :cover_photo, :string
  end
end
