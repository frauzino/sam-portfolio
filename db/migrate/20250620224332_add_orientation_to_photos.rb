class AddOrientationToPhotos < ActiveRecord::Migration[7.1]
  def change
    add_column :photos, :orientation, :string, null: false, default: 'portrait'
  end
end
