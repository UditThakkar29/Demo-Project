class AddColumnToSprint < ActiveRecord::Migration[6.1]
  def change
    add_column :sprints, :goal, :text
  end
end
