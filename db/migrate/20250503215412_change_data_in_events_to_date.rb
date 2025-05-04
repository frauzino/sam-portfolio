class ChangeDataInEventsToDate < ActiveRecord::Migration[7.1]
  def change
    rename_column :events, :data, :date
  end
end
