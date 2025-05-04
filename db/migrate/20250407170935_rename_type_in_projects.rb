class RenameTypeInProjects < ActiveRecord::Migration[7.1]
  def change
    rename_column :projects, :type, :project_type
  end
end
