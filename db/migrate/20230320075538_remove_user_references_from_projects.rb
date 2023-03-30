class RemoveUserReferencesFromProjects < ActiveRecord::Migration[6.1]
  def change
    change_table :projects do |t|
      t.remove_references :user
    end
  end
end
