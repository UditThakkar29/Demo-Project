class CreateSprints < ActiveRecord::Migration[6.1]
  def change
    create_table :sprints do |t|
      t.string :name
      t.datetime :start_time
      t.integer :duration
      t.references :board, null: false, foreign_key: true

      t.timestamps
    end
  end
end
