class CreateProjects < ActiveRecord::Migration[7.1]
  def change
    create_table :projects do |t|
      t.string :title
      t.string :type
      t.text :description

      t.timestamps
    end
  end
end
