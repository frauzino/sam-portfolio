class CreatePhotos < ActiveRecord::Migration[7.1]
  def change
    create_table :photos do |t|
      t.string :title
      t.text :description
      t.string :photo_type
      t.string :link

      t.timestamps
    end
  end
end
