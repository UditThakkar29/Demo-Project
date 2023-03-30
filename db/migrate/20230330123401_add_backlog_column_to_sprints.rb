class AddBacklogColumnToSprints < ActiveRecord::Migration[6.1]
  def change
    add_column :sprints, :backlog_sprint, :boolean
  end
end
