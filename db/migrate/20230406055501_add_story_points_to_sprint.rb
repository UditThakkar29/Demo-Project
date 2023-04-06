class AddStoryPointsToSprint < ActiveRecord::Migration[6.1]
  def change
    add_column :sprints, :total_story_points, :integer
    add_column :sprints, :completed_story_points, :integer
  end
end
