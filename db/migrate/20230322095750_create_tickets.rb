class CreateTickets < ActiveRecord::Migration[6.1]
  def change
    create_table :tickets do |t|
      t.string :name
      t.text :summary
      t.string :priority
      t.string :status
      t.integer :story_point

      t.timestamps
    end
  end
end
