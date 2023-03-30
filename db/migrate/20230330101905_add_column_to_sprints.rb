class AddColumnToSprints < ActiveRecord::Migration[6.1]
  def change
    add_column :sprints, :current_sprint, :boolean
  end
end
