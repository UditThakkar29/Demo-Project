class CreateSprintTickets < ActiveRecord::Migration[6.1]
  def change
    create_table :sprint_tickets do |t|
      t.boolean :status
      t.references :sprint, null: false, foreign_key: true
      t.references :ticket, null: false, foreign_key: true

      t.timestamps
    end
  end
end
