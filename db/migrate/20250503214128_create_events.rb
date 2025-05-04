class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.string :title
      t.string :data
      t.string :link

      t.timestamps
    end
  end
end
