class RemoveTypeFromProjects < ActiveRecord::Migration[7.1]
  def change
    remove_column :projects, :type, :string
  end
end
